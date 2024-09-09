//
//  RegistrationComponent.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 09.09.2024.
//

import UIKit
import NeedleFoundation

class RegistrationComponent: Component<RepositoryDependency> {
    private func viewModel(_ coordinator: Coordinator) -> RegistrationViewModel {
        .init(coordinator: coordinator, repository: dependency.authRepository)
    }

    func viewController(coordinator: Coordinator) -> UIViewController {
        RegistrationViewController(viewModel: viewModel(coordinator))
    }
}
