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
        // прописываем путь к данным, от которых будем строить наследника, в правилах доступа прописываем
        let ref = Database.database(url: DB.url)
            .reference()
        return ref
    }()

    public func saveData(todo: ToDoDTO) async -> Result<Bool, Error> {
        guard databasePath != nil else { return .failure(NetworkServiceError.invalidDatabase) }

        do {
            let json = try await encodeData(todo)
            try await save(id: todo.id, json)

            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }
    
    private func encodeData(_ todo: ToDoDTO) async throws -> Any {
        let data = try encoder.encode(todo)
        return try JSONSerialization.jsonObject(with: data)
    }

    private func save(id: String, _ json: Any) async throws {
        guard let uid = UserData.shared.user?.id else { throw NetworkServiceError.cancelled }
        //Записывает словарь в путь к базе данных как дочерний узел с автоматически созданным идентификатором.
        try await databasePath?
            .child(DB.Names.todo) // Название БД
            .child(uid)// uid пользователя, который залогинен
            .child(id)// id ToDo или автогенерация .childByAutoId()
            .setValue(json)
    }
}
// правила
/*
 {
   "rules": {
     "users": {
       "$uid": {
           ".read": "auth != null && auth.uid == $uid",
           ".write": "auth != null && auth.uid == $uid"
       }
     },
     "todo": {
       "$uid": {
           ".read": "auth != null && auth.uid == $uid",
           ".write": "auth != null && auth.uid == $uid"
       }
     }
   }
 }
*/
