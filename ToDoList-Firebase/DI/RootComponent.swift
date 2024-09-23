//
//  RootComponent.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import Foundation
import NeedleFoundation

class RootComponent: BootstrapComponent, AuthRepositoryDependency, DataRepositoryDependency {

    // Authentication-related dependencies
    var authComponent: AuthComponent {
        shared { AuthComponent(parent: self) }
    }

    private var authNetworkService: AuthService {
        shared { FirebaseAuthServiceImpl() }
    }

    public var authRepository: AuthRepository {
        shared { FirebaseAuthRepositoryImpl(service: authNetworkService) }
    }

    // Data-related dependencies
    var dataComponent: DataComponent {
        shared { DataComponent(parent: self) }
    }

    private var dataNetworkService: DataService {
        shared { FirebaseRestApiDataServiceImpl() }
    }

    public var dataRepository: DataRepository {
        shared { FirebaseDataRepositoryImpl(service: dataNetworkService) }
    }

}
