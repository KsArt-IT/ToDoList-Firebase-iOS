//
//  LoginViewModel.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import Foundation
import Combine

class LoginViewModel: TaskViewModel {

    private weak var coordinator: Coordinator?
    private let repository: AuthRepository

    @Published var email = ""
    @Published var password = ""
    @Published var viewStates: ViewStates = .none

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
    }

    public func submitLogin() {
        print("email: \(email) password: \(password)")
        guard !email.isEmpty && !password.isEmpty else { return }

        launch { [weak self] in
            guard let self else { return }

            let result = await self.repository.signIn(email: self.email, password: self.password)
            DispatchQueue.main.async {
                switch result {
                    case .success(_):
                        // успешная авторизация, перейти на основной экран
                        self.coordinator?.navigation(to: .main)
                    case .failure(let error):
                        guard let error = error as? NetworkServiceError else { return }

                        self.viewStates = switch error {
                            case .invalidRequest, .invalidResponse,
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
            }
        }
    }

    public func toLoginGoogle() {
        coordinator?.navigation(to: .loginGoogle)
    }

    public func toRegistration() {
        coordinator?.navigation(to: .registration)
    }

}
