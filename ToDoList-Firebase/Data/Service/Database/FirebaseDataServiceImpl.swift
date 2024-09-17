//
//  FirebaseDataServiceImpl.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import Foundation
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

final class FirebaseDataServiceImpl: DataService {
    private let encoder = JSONEncoder()

    private lazy var databasePath: DatabaseReference? = {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }

        // прописываем путь к данным, от которых будем строить наследника, в правилах доступа прописываем
        let ref = Database.database()
            .reference()
            .child("users/\(uid)/todo")
        return ref
    }()

    public func saveToDo(_ todo: ToDoDTO) async -> Result<Bool, Error> {
        guard let databasePath else { return .failure(NetworkServiceError.invalidDatabase) }

        do {
            let json = try await encodeData(todo)
            try await save(json)

            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    private func encodeData(_ todo: ToDoDTO) async throws -> Any {
        let data = try encoder.encode(todo)
        return try JSONSerialization.jsonObject(with: data)
    }

    private func save(_ json: Any) async throws {
        //Записывает словарь в путь к базе данных как дочерний узел с автоматически созданным идентификатором.
        try await databasePath?.childByAutoId()
            .setValue(json)
    }
}

// правила
/*
 {
   "rules": {
     "users": {
       "$uid": {
         "todo": {
           ".read": "auth != null && auth.uid == $uid",
           ".write": "auth != null && auth.uid == $uid"
         }
       }
     }
   }
 }
 */
