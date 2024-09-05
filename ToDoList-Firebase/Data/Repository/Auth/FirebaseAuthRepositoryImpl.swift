//
//  FirebaseAuthRepositoryImpl.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import Foundation

final class FirebaseAuthRepositoryImpl: AuthRepository {

    private let service: AuthService

    init(service: AuthService) {
        self.service = service
    }
}
