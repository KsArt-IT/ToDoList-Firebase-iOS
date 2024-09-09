//
//  Coordinator.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//


import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get }
    var childCoordinators: [Coordinator] { get set }

    func navigation(to route: Route)
    func finish()
}

extension Coordinator {
    func add(child coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func remove(child coordinator: Coordinator) {
        for (index, child) in childCoordinators.enumerated() {
            if child === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    // сообщить родителю что закончил
    func onFinished() {
        parentCoordinator?.remove(child: self)
    }
}

enum Route {
    case root
    case start
    case main
    case loginGoogle
    case registration
    case detail(id: Int)
}
