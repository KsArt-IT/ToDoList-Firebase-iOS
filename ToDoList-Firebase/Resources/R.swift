//
//  R.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 06.09.2024.
//

import Foundation

enum R {

    enum Strings {
        static let dateTimeFormat =  "EEEE, dd.MM.yyyy HH:mm"
        static let dateTimeUTCFormat =  "yyyy.MM.dd HH:mm:ssZ"

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
        static let createButton = String(localized: "createButton")

        // actions
        static let deleteAction = String(localized: "deleteButton")
        static let forTomorrowAction = String(localized: "forTomorrowButton")
        static let changeAction = String(localized: "Change")
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
        static let todoFillFields = String(localized: "todoFillFields")

        // title screen
        static let titleMain = String(localized: "titleMain")
        static let titleLogin = String(localized: "titleLogin")
        static let titleRegistration = String(localized: "titleRegistration")
        static let titleReset = String(localized: "titleReset")
        static let titleCreate = String(localized: "titleCreate")

        // todo
        static let titleToDo = String(localized: "titleToDo")
        static let placeholderTitle = String(localized: "placeholderTitle")
        static let placeholderNote = String(localized: "placeholderNote")
    }
}
