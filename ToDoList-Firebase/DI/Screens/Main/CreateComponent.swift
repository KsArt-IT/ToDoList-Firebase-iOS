//
//  MainComponent.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 17.09.2024.
//

import UIKit
import NeedleFoundation

class CreateComponent: Component<DataRepositoryDependency> {
    private func viewModel(_ coordinator: Coordinator, item: ToDoItem?) -> CreateViewModel {
        .init(coordinator: coordinator, repository: dependency.dataRepository, item: item)
    }

    func viewController(coordinator: Coordinator, item: ToDoItem?) -> UIViewController {
        CreateViewController(viewModel: viewModel(coordinator, item: item))
    }
}
