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
            case .edit(let item): startCreateFlow(item: item)
            case .back: toBack()
            default: break
        }
    }

    private func startMainFlow() {
        let vc = component.dataComponent.mainComponent.viewController(coordinator: self)
        navController?.pushViewController(vc, animated: true)
    }

    private func startCreateFlow(item: ToDoItem?) {
        let vc = component.dataComponent.createComponent.viewController(coordinator: self, item: item)
        navController?.present(vc, animated: true)
    }

    private func startLoginFlow() {
        parentCoordinator?.navigation(to: .login)
        finish()
    }

    private func toBack() {
        navController?.dismiss(animated: true)
    }

    deinit {
        print("MainCoordinator.deinit")
    }

}
