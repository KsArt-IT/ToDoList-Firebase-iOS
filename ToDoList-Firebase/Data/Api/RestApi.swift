//
//  DB.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 18.09.2024.
//

import Foundation

enum RestApi {
    case users
    case todos
    case todo(id: String)

    enum DB {
        static let todo = "todo"
        static let users = "users"

        enum Users {
            static let name = "name"
            static let email = "email"
            static let photoUrl = "photoUrl"
            static let last = "last"
        }
    }

    enum Metod {
        static let get = "GET"
        static let put = "PUT"
        static let post = "POST"
        static let patch = "PATCH"
        static let delete = "DELETE"
    }
}

extension RestApi {

    static func getUrl(_ endpoint: RestApi, uid: String, token: String) -> URL? {
        let path = switch endpoint {
            case .users:
                "\(DB.users)/\(uid)"
            case .todos:
                "\(DB.todo)/\(uid)"
            case .todo(let id):
                "\(DB.todo)/\(uid)/\(id)"
        }
        guard let url = URL(string: "\(Self.baseURL)/\(path).json?auth=\(token)") else { return nil }
        print("Url= \(url.absoluteString)")
        return url
    }

    static let baseURL = "https://todolist-firebase-9ecf6-default-rtdb.europe-west1.firebasedatabase.app"

}
