//
//  LoginViewModel.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import Foundation

class LoginViewModel: TaskViewModel {

    private let coordinator: Coordinator
    private let repository: AuthRepository

    init(coordinator: Coordinator, repository: AuthRepository) {
        self.coordinator = coordinator
        self.repository = repository
    }
}
