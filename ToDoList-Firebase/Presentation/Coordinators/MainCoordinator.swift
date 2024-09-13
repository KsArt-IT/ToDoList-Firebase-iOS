//
//  MainCoordinator.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import Foundation

final class MainCoordinator: BaseCoordinator {

    override func navigation(to route: Route = .start) {
        switch route {
            case .start: startMainFlow()
            case .login: startLoginFlow()
            default: break
        }
    }

    private func startMainFlow() {
        let vc = component.mainComponent.viewController(coordinator: self)
        navController?.pushViewController(vc, animated: true)
    }

    private func startLoginFlow() {
        parentCoordinator?.navigation(to: .login)
        finish()
    }

    deinit {
        print("MainCoordinator.deinit")
    }

}
