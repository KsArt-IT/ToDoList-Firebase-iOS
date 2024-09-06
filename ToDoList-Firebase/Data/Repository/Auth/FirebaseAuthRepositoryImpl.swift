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

    func signIn(email: String, password: String) async -> Result<Bool, Error> {
        await service.signIn(email: email, password: password)
    }

    func signUp(email: String, password: String) async -> Result<Bool, Error> {
        await service.signUp(email: email, password: password)
    }
}
