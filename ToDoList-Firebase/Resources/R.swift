//
//  R.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 06.09.2024.
//

import Foundation

enum R {

    enum Strings {
        // email
        static let email = String(localized: "Email")
        static let emailPlaceholder = String(localized: "EmailPlaceholder")

        // password
        static let password = String(localized: "Password")
        static let passwordConfirm = String(localized: "passwordConfirm")
        static let passwordPlaceholder = String(localized: "PasswordPlaceholder")
        static let passwordsDoNotMatch = String(localized: "passwordsDoNotMatch")
        static let passwordForgot = String(localized: "passwordForgot")

        // buttons
        static let loginButton = String(localized: "Login")
        static let logoutButton = String(localized: "Logout")
        static let loginGoogleButton = String(localized: "loginGoogle")
        static let registrationButton = String(localized: "registrationButton")
        static let resetButton = String(localized: "resetButton")
        static let addToDoButton = String(localized: "addToDoButton")

        // actions
        static let deleteAction = String(localized: "deleteButton")
        static let forTomorrowAction = String(localized: "forTomorrowButton")
        static let renameAction = String(localized: "renameButton")
        static let okAction = String(localized: "okAction")
        static let cancelAction = String(localized: "cancelAction")

        // auth errors
        static let userNotFound = String(localized: "userNotFound")
        static let userDisabled = String(localized: "userDisabled")
        static let invalidCredential = String(localized: "invalidCredential")

        static let invalidEmail = String(localized: "invalidEmail")
        static let emailAlreadyInUse = String(localized: "emailAlreadyInUse")

        static let weakPassword = String(localized: "weakPassword")
        static let wrongPassword = String(localized: "wrongPassword")

        // alert
        static let titleError = String(localized: "Error")
        static let passwordResetRequestSent = String(localized: "passwordResetRequestSent")

        // title screen
        static let titleMain = String(localized: "titleMain")
        static let titleLogin = String(localized: "titleLogin")
        static let titleRegistration = String(localized: "titleRegistration")
        static let titleReset = String(localized: "titleReset")

        // todo
        static let titleToDo = String(localized: "titleToDo")
        static let placeholderTitle = String(localized: "placeholderTitle")
        static let placeholderNote = String(localized: "placeholderNote")
    }
}
