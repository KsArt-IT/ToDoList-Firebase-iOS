//
//  AuthenticationComponent.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 20.09.2024.
//

import Foundation
import NeedleFoundation

class AuthComponent: Component<AuthRepositoryDependency> {

    var loginComponent: LoginComponent {
        LoginComponent(parent: self)
    }

    var registrationComponent: RegistrationComponent {
        RegistrationComponent(parent: self)
    }

    var resetPasswordComponent: ResetPasswordComponent {
        ResetPasswordComponent(parent: self)
    }
}
