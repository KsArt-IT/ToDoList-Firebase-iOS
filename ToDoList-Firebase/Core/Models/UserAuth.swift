//
//  UserAuth.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 12.09.2024.
//

import Foundation

struct UserAuth {
    let id: String
    let token: String
    let refreshToken: String
    let name: String
    let email: String
    let photoUrl: String?
    let photo: Data?
    let date: Date
}
