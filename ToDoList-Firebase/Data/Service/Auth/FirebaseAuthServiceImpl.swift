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
                    case .wrongPassword:
                            .failure(NetworkServiceError.authPasswordError(R.Strings.wrongPassword))
                    case .invalidEmail:
                            .failure(NetworkServiceError.authPasswordError(R.Strings.wrongPassword))
                    case .userNotFound:
                            .failure(NetworkServiceError.authPasswordError(R.Strings.wrongPassword))
                    case .userDisabled:
                            .failure(NetworkServiceError.authPasswordError(R.Strings.wrongPassword))
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
                            .failure(NetworkServiceError.authPasswordError(R.Strings.emailAlreadyInUse))
                    case .weakPassword:
                            .failure(NetworkServiceError.authPasswordError(R.Strings.weakPassword))
                    case .invalidEmail:
                            .failure(NetworkServiceError.authPasswordError(R.Strings.invalidEmail))
                    default:
                            .failure(NetworkServiceError.networkError(error))
                }
            } else {
                .failure(NetworkServiceError.networkError(error))
            }
        }
    }

}
