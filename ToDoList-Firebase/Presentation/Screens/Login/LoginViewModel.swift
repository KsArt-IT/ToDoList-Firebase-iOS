//
//  LoginViewModel.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import Foundation
import Combine
import FirebaseCore
import FirebaseAuth

class LoginViewModel: TaskViewModel {

    private weak var coordinator: Coordinator?
    private let repository: AuthRepository

    @Published var email = ""
    @Published var password = ""
    @Published var viewStates: ViewStates = .none
    @Published var requestLoginGoogle: String?

    var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email.map {
            $0.isEmail()
        }.eraseToAnyPublisher()
    }

    var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $password.map {
            !$0.isEmpty
        }.eraseToAnyPublisher()
    }

    var isLoginButtonEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isValidEmailPublisher, isValidPasswordPublisher)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }

    init(coordinator: Coordinator, repository: AuthRepository) {
        self.coordinator = coordinator
        self.repository = repository
        super.init()
        
        self.checkAuthorization()
    }

    private func checkAuthorization() {
        launch { [weak self] in
            // сначала проверим необходим ли logout
            if UserData.shared.isNeedLogout {
                await self?.logout()
            } else {
                // проверить авторизацию
                UserData.shared.user = await self?.getAuthUser()
            }
            // перейдем на главный экран
            if UserData.shared.user != nil {
                self?.toMain()
            }
        }
    }

    private func logout() async {
        let result = await repository.logout()
        // проверить на ошибки сети
        switch result {
            case .success(_):
                UserData.shared.user = nil
            case .failure(let error):
                guard let networkError = error as? NetworkServiceError else { return }
                switch networkError {
                    case .cancelled: break
                    default:
                        // ошибки сети необходимо вывести алерт
                        print(networkError.localizedDescription)
                }
        }
    }

    private func getAuthUser() async -> UserAuth? {
        let result = await repository.fetchAuthUser()
        switch result {
            case .success(let user):
                return user
            case .failure(let error):
                guard let networkError = error as? NetworkServiceError else { return nil }
                switch networkError {
                    case .cancelled: return nil
                    default:
                        // ошибки сети необходимо вывести алерт
                        print(networkError.localizedDescription)
                }
                return nil
        }
    }

    public func submitLogin() {
        guard !email.isEmpty && !password.isEmpty else { return }

        launch { [weak self] in
            guard let self else { return }

            let result = await self.repository.signIn(email: self.email, password: self.password)
            switch result {
                case .success(_):
                    // успешная авторизация, перейти на основной экран
                    self.toMain()
                case .failure(let error):
                    self.showError(error: error)
            }
        }
    }

    public func toLoginGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        requestLoginGoogle = clientID
    }

    public func submitLogin(idToken: String, accessToken: String) {
        launch { [weak self] in
            let result = await self?.repository.signIn(withIDToken: idToken, accessToken: accessToken)
            switch result {
                case .success(_):
                    // успешная авторизация, перейти на основной экран
                    self?.toMain()
                case .failure(let error):
                    self?.showError(error: error)
                case .none:
                    break
            }
        }
    }

    private func showError(error: Error) {
        guard let error = error as? NetworkServiceError else { return }

        self.viewStates = switch error {
            case .invalidRequest, .invalidResponse, .invalidDatabase,
                    .statusCode(_, _), .decodingError(_), .networkError(_),
                    .invalidCredential, .userNotFound, .userDisabled:
                    .failure(error: .alert, message: error.localizedDescription)
            case .invalidEmail, .emailAlreadyInUse:
                    .failure(error: .email, message: error.localizedDescription)
            case .wrongPassword, .weakPassword:
                    .failure(error: .password, message: error.localizedDescription)
            case .cancelled:
                    .none
        }

    }

    deinit {
        print("LoginViewModel.deinit")
    }

    // MARK: - Navigation
    public func toRegistration() {
        navigate(to: .registration)
    }

    public func toResetPassword() {
        navigate(to: .resetPassword)
    }

    public func toMain() {
        navigate(to: .main)
    }

    private func navigate(to screen: Route) {
        DispatchQueue.main.async { [weak self] in
            self?.coordinator?.navigation(to: screen)
        }
    }
}
