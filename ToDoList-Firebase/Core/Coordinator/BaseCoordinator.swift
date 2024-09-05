//
//  BaseCoordinator.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import UIKit
import NeedleFoundation

open class BaseCoordinator: Coordinator {

    weak var parentCoordinator: Coordinator? = nil
    var childCoordinators: [Coordinator] = []

    let navController: UINavigationController?
    let component: RootComponent

    init(parent coordinator: Coordinator? = nil, navController: UINavigationController?, component: RootComponent) {
        self.parentCoordinator = coordinator
        self.navController = navController
        self.component = component
    }

    func navigation(to route: Route = .start) {
        fatalError("Child should implements")
    }

    func finish() {
        for coordinator in childCoordinators {
            coordinator.finish()
        }
        childCoordinators.removeAll()
        onFinished()
    }

}
