//
//  LoginComponent.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import UIKit
import NeedleFoundation

class MainComponent: Component<DataRepositoryDependency> {
    private func viewModel(_ coordinator: Coordinator) -> MainViewModel {
        .init(coordinator: coordinator, repository: dependency.dataRepository)
    }

    func viewController(coordinator: Coordinator) -> UIViewController {
        MainViewController(viewModel: viewModel(coordinator))
    }
}
