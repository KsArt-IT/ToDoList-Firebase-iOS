//
//  FirebaseAuthServiceImpl.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthServiceImpl: AuthService {

    func signIn(email: String, password: String) async -> Result<Bool, Error>{

        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            print("Auth result=\(result)")
            return .success(true)
        } catch {
            return if let errorCode = AuthErrorCode(rawValue: error._code) {
                switch errorCode {
                    case .invalidEmail:
                            .failure(NetworkServiceError.invalidEmail)
                    case .wrongPassword:
                            .failure(NetworkServiceError.wrongPassword)
                    case .userNotFound:
                            .failure(NetworkServiceError.userNotFound)
                    case .userDisabled:
                            .failure(NetworkServiceError.userDisabled)
                    case .invalidCredential:
                            .failure(NetworkServiceError.invalidCredential)
                    default:
                            .failure(NetworkServiceError.networkError(error))
                }
            } else {
                .failure(NetworkServiceError.networkError(error))
            }
        }
    }

    func signUp(email: String, password: String) async -> Result<Bool, Error>{

        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("Auth result=\(result)")
            return .success(true)
        } catch {
            return if let errorCode = AuthErrorCode(rawValue: error._code) {
                switch errorCode {
                    case .emailAlreadyInUse:
                            .failure(NetworkServiceError.emailAlreadyInUse)
                    case .invalidEmail:
                            .failure(NetworkServiceError.invalidEmail)
                    case .weakPassword:
                            .failure(NetworkServiceError.weakPassword)
                    default:
                            .failure(NetworkServiceError.networkError(error))
                }
            } else {
                .failure(NetworkServiceError.networkError(error))
            }
        }
    }

    func resetPassword(email: String) async -> Result<Bool, Error>{

        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            print("Auth result=Ok")
            return .success(true)
        } catch {
            return if let errorCode = AuthErrorCode(rawValue: error._code) {
                switch errorCode {
                    case .emailAlreadyInUse:
                            .failure(NetworkServiceError.emailAlreadyInUse)
                    case .invalidEmail:
                            .failure(NetworkServiceError.invalidEmail)
                    case .weakPassword:
                            .failure(NetworkServiceError.weakPassword)
                    default:
                            .failure(NetworkServiceError.networkError(error))
                }
            } else {
                .failure(NetworkServiceError.networkError(error))
            }
        }
    }

}
