//
//  LoginCoordinator.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import Foundation

final class LoginCoordinator: BaseCoordinator {

    override func navigation(to route: Route) {
        switch route {
            case .start: startLoginFlow()
            default: break
        }
    }

    private func startLoginFlow() {
        let vc = component.loginComponent.viewController(coordinator: self)
        navController?.pushViewController(vc, animated: true)
    }

    deinit {
        print("LoginCoordinator.deinit")
    }

}
