//
//  R.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 06.09.2024.
//

import Foundation

enum R {

    enum Strings {
        static let email = String(localized: "Email")
        static let emailPlaceholder = String(localized: "EmailPlaceholder")

        static let password = String(localized: "Password")
        static let passwordPlaceholder = String(localized: "PasswordPlaceholder")

        static let loginButton = String(localized: "Login")
        static let loginGoogleButton = String(localized: "loginGoogle")
        static let registrationButton = String(localized: "registrationButton")

        // auth errors
        static let userNotFound = String(localized: "userNotFound")
        static let userDisabled = String(localized: "userDisabled")
        static let invalidCredential = String(localized: "invalidCredential")

        static let invalidEmail = String(localized: "invalidEmail")
        static let emailAlreadyInUse = String(localized: "emailAlreadyInUse")

        static let weakPassword = String(localized: "weakPassword")
        static let wrongPassword = String(localized: "wrongPassword")
    }
}
