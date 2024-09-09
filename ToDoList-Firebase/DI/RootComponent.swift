//
//  RootComponent.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import Foundation
import NeedleFoundation

// needle generate TMDB_Movies/DI/NeedleGenerated.swift TMDB_Movies/
class RootComponent: BootstrapComponent {

    private var authNetworkService: AuthService {
        shared { FirebaseAuthServiceImpl() }
    }

    public var authRepository: AuthRepository {
        shared { FirebaseAuthRepositoryImpl(service: authNetworkService) }
    }

    var loginComponent: LoginComponent {
        LoginComponent(parent: self)
    }

    var registrationComponent: RegistrationComponent {
        RegistrationComponent(parent: self)
    }

}
