//
//  ResetViewModel.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 10.09.2024.
//

import Foundation
import Combine

final class ResetViewModel: TaskViewModel {

    private weak var coordinator: Coordinator?
    private let repository: AuthRepository

    @Published var email = ""
    @Published var viewStates: ViewStates = .none

    var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email.map {
            $0.isEmail()
        }.eraseToAnyPublisher()
    }

    init(coordinator: Coordinator, repository: AuthRepository) {
        self.coordinator = coordinator
        self.repository = repository
    }

    public func submitResetPassword() {
        guard !email.isEmpty else { return }

        launch { [weak self] in
            guard let self else { return }

            let result = await self.repository.resetPassword(email: self.email)
            switch result {
                case .success(_):
                    // запрос на сброс пароля отправлен
                    self.viewStates = .failure(error: .password, message: R.Strings.passwordResetRequestSent)
                case .failure(let error):
                    guard let error = error as? NetworkServiceError else { return }

                    self.viewStates = switch error {
                        case .invalidEmail, .emailAlreadyInUse:
                                .failure(error: .email, message: error.localizedDescription)
                        case .cancelled:
                                .none
                        default:
                                .failure(error: .alert, message: error.localizedDescription)
                    }

            }
        }
    }
}
