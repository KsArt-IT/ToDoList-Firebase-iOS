//
//  LoginViewModel.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import Foundation

class LoginViewModel: TaskViewModel {

    private let coordinator: Coordinator
    private let repository: AuthRepository

    init(coordinator: Coordinator, repository: AuthRepository) {
        self.coordinator = coordinator
        self.repository = repository
    }

    func login(email: String, password: String) {
        guard !email.isEmpty && !password.isEmpty else { return }

        launch { [weak self] in
            let result = await self?.repository.signIn(email: email, password: password)
            switch result {
                case .success(let isLogin):
                    print("Login in = \(isLogin)")
                case .failure(let error):
                    guard let error = error as? NetworkServiceError else { return }

                    print("Login error = \(error.localizedDescription)")
                case .none:
                    break
            }

        }
    }

    func registration(email: String, password: String) {
        guard !email.isEmpty && !password.isEmpty else { return }

        launch { [weak self] in
            let result = await self?.repository.signUp(email: email, password: password)
            switch result {
                case .success(let isLogin):
                    print("Login in = \(isLogin)")
                case .failure(let error):
                    guard let error = error as? NetworkServiceError else { return }

                    print("Login error = \(error.localizedDescription)")
                case .none:
                    break
            }

        }
    }

}
