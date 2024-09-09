//
//  NetworkServiceError.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 06.09.2024.
//


import Foundation

enum NetworkServiceError: Error {
    case invalidRequest
    case invalidResponse
    case statusCode(code: Int, message: String)
    case decodingError(DecodingError)
    case networkError(Error)
    case cancelled // отменен запрос
    // FirebaseAuth
    case invalidEmail
    case emailAlreadyInUse

    case wrongPassword
    case weakPassword

    case userNotFound
    case userDisabled
    case invalidCredential

    var localizedDescription: String {
        switch self {
            case .invalidRequest:
                "The request is invalid."
            case .invalidResponse:
                "The response is invalid."
            case .statusCode(let code, let message):
                "Unexpected status code: \(code). \(message)"
            case .decodingError(let error):
                "Decoding failed with error: \(error.localizedDescription)."
            case .networkError(let error):
                "Network error occurred: \(error.localizedDescription)."
            case .cancelled:
                ""
            case .invalidEmail:
                R.Strings.invalidEmail
            case .emailAlreadyInUse:
                R.Strings.emailAlreadyInUse
            case .wrongPassword:
                R.Strings.wrongPassword
            case .weakPassword:
                R.Strings.weakPassword
            case .userNotFound:
                R.Strings.userNotFound
            case .userDisabled:
                R.Strings.userDisabled
            case .invalidCredential:
                R.Strings.invalidCredential
        }
    }
}
