//
//  AppCoordinator.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import UIKit

final class AppCoordinator: BaseCoordinator {

    override func navigation(to route: Route) {
        switch route {
            case .start: startLoginFlow()
            default: break
        }
    }

    private func startLoginFlow() {
        let coordinator = LoginCoordinator(parent: self, navController: navController, component: component)
        add(child: coordinator)
        coordinator.navigation(to: .start)
    }

    deinit {
        print("AppCoordinator.deinit")
    }
}
