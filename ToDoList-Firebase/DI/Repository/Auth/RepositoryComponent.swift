//
//  RepositoryComponent.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import Foundation
import NeedleFoundation

class RepositoryComponent: Component<RepositoryDependency> {
    private var authNetworkService: AuthService {
        shared { FirebaseAuthServiceImpl() }
    }

    public var authRepository: AuthRepository {
        shared { FirebaseAuthRepositoryImpl(service: authNetworkService) }
    }
}
