//
//  ResetPasswordComponent.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 10.09.2024.
//

import UIKit
import NeedleFoundation

class ResetPasswordComponent: Component<AuthRepositoryDependency> {
    private func viewModel(_ coordinator: Coordinator) -> ResetViewModel {
        .init(coordinator: coordinator, repository: dependency.authRepository)
    }

    func viewController(coordinator: Coordinator) -> UIViewController {
        ResetViewController(viewModel: viewModel(coordinator))
    }
}
