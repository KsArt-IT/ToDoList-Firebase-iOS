//
//  LoginComponent.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import UIKit
import NeedleFoundation

class LoginComponent: Component<AuthRepositoryDependency> {
    private func viewModel(_ coordinator: Coordinator) -> LoginViewModel {
        .init(coordinator: coordinator, repository: dependency.authRepository)
    }

    func viewController(coordinator: Coordinator) -> UIViewController {
        LoginViewController(viewModel: viewModel(coordinator))
    }
}
