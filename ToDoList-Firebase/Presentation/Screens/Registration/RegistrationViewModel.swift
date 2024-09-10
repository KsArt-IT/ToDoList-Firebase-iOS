//
//  RegistrationViewModel.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 09.09.2024.
//

import Foundation
import Combine

final class RegistrationViewModel: TaskViewModel {

    private weak var coordinator: Coordinator?
    private let repository: AuthRepository

    @Published var email = ""
    @Published var password = ""
    @Published var passwordConfirm = ""
    @Published var viewStates: ViewStates = .none

    private var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email.map {
            $0.isEmail()
        }.eraseToAnyPublisher()
    }

    private var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $password.map {
            !$0.isEmpty
        }.eraseToAnyPublisher()
    }

    private var isValidPasswordConfirmPublisher: AnyPublisher<Bool, Never> {
        $passwordConfirm.map {
            !$0.isEmpty
        }.eraseToAnyPublisher()
    }

    var isRegistrationButtonEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isValidEmailPublisher, isValidPasswordConfirmPublisher)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }

    init(coordinator: Coordinator, repository: AuthRepository) {
        self.coordinator = coordinator
        self.repository = repository
    }

    public func submitRegistration() {
        guard !email.isEmpty && !password.isEmpty && password == passwordConfirm else {
            if password != passwordConfirm {
                viewStates = .failure(error: .password, message: R.Strings.passwordsDoNotMatch)
            }
            return
        }

        launch { [weak self] in
            guard let self else { return }

            let result = await self.repository.signUp(email: self.email, password: self.password)
            DispatchQueue.main.async {
                switch result {
                    case .success(_):
                        // успешная регистрация, перейти на экран логина
                        self.coordinator?.navigation(to: .back)
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
}
