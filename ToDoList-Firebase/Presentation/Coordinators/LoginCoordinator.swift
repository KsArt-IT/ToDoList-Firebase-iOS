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
            case .main: startMainFlow()
            case .start: startLoginFlow()
            case .registration: startRegistrationFlow()
            case .resetPassword: startResetPasswordFlow()
            case .back: navController?.popViewController(animated: true)
            default: break
        }
    }

    private func startMainFlow() {
        parentCoordinator?.navigation(to: .main)
        finish()
    }

    private func startLoginFlow() {
        let vc = component.loginComponent.viewController(coordinator: self)
        navController?.pushViewController(vc, animated: true)
    }

    private func startRegistrationFlow() {
        let vc = component.registrationComponent.viewController(coordinator: self)
        navController?.pushViewController(vc, animated: true)
    }

    private func startResetPasswordFlow() {
        let vc = component.resetPasswordComponent.viewController(coordinator: self)
        navController?.pushViewController(vc, animated: true)
    }

    deinit {
        print("LoginCoordinator.deinit")
    }

}
