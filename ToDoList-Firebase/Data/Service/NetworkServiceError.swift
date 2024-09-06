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
    case authEmailError(String) // вывести текст под email
    case authPasswordError(String) // вывести текст под паролем
    case authUserError(String) // вывести алерт
    case cancelled // отменен запрос

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
            case .authEmailError(let str):
                str
            case .authPasswordError(let str):
                str
            case .authUserError(let str):
                str
            case .cancelled:
                ""
        }
    }
}
