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
            case .start, .login: startLoginFlow()
            case .main: startMainFlow()
            default: break
        }
    }

    private func startMainFlow() {
        let coordinator = MainCoordinator(parent: self, navController: navController, component: component)
        start(with: coordinator)
    }

    private func startLoginFlow() {
        let coordinator = LoginCoordinator(parent: self, navController: navController, component: component)
        start(with: coordinator)
    }

    private func start(with coordinator: Coordinator) {
        // очистим переходы
        navController?.viewControllers.removeAll()
        add(child: coordinator)
        coordinator.navigation(to: .start)
    }

    deinit {
        finish()
        print("AppCoordinator.deinit")
    }
}
