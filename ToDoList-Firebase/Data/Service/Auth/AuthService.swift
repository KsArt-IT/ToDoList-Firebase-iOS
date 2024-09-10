//
//  NetworkService.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import Foundation

protocol AuthService {
    func signIn(email: String, password: String) async -> Result<Bool, Error>
    func signUp(email: String, password: String) async -> Result<Bool, Error>
    func resetPassword(email: String) async -> Result<Bool, Error>
    func signIn(withIDToken: String, accessToken: String) async -> Result<Bool, Error>
}
