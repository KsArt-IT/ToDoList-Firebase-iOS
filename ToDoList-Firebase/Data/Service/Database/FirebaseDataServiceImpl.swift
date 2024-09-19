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
import Combine

final class FirebaseDataServiceImpl: DataService {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private lazy var databasePath: DatabaseReference? = {
        // прописываем путь к данным, от которых будем строить наследника, в правилах доступа прописываем
        let db = Database.database(url: DB.url)
        db.isPersistenceEnabled = true
        return db.reference()
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

    public func loadData() async -> Result<[ToDoDTO], Error>  {
        guard databasePath != nil else { return .failure(NetworkServiceError.invalidDatabase) }

        do {
            let json = try await loadAll()
            let result: [ToDoDTO] = if let json {
                try decodeData(json)
            } else {
                []
            }
            return .success(result)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    public func updateData(todo: ToDoDTO) async -> Result<Bool, Error> {
        guard databasePath != nil else { return .failure(NetworkServiceError.invalidDatabase) }

        do {
            let json = try await encodeData(todo)
            try await update(id: todo.id, json)

            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    public func deleteData(id: String) async -> Result<Bool, Error> {
        guard databasePath != nil else { return .failure(NetworkServiceError.invalidDatabase) }
        guard let uid = UserData.shared.user?.id else { return .failure(NetworkServiceError.cancelled) }

        do {
            try await databasePath?
                .child(DB.Todo.name) // Название БД
                .child(uid)// uid пользователя, который залогинен
                .child(id)
                .removeValue() // удалить по ключу

            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    private func loadAll() async throws -> [String: Any]? {
        guard let uid = UserData.shared.user?.id else { throw NetworkServiceError.cancelled }

        let snapshot = try await databasePath?
            .child(DB.Todo.name) // Название БД
            .child(uid)// uid пользователя, который залогинен
            .queryOrdered(byChild: DB.Todo.Fields.date) // отсортировать по
            .queryLimited(toFirst: 10) // первые данные
            .getData() // получить данные
        return if let value = snapshot?.value as? [String: Any] {
            value
        } else {
            nil
        }
    }

    private func save(id: String, _ json: Any) async throws {
        guard let uid = UserData.shared.user?.id else { throw NetworkServiceError.cancelled }
        // Записывает словарь в путь к базе данных как дочерний узел с id To-Do
        try await databasePath?
            .child(DB.Todo.name) // Название БД
            .child(uid)// uid пользователя, который залогинен
            .child(id)// id ToDo или автогенерация .childByAutoId()
            .setValue(json)
    }

    private func update(id: String, _ json: Any) async throws {
        guard let uid = UserData.shared.user?.id else { throw NetworkServiceError.cancelled }
        // Записывает словарь в путь к базе данных как дочерний узел с id To-Do
        try await databasePath?
            .child(DB.Todo.name) // Название БД
            .child(uid)// uid пользователя, который залогинен
            .updateChildValues([id: json])
    }

    private func encodeData(_ todo: ToDoDTO) async throws -> Any {
        let data = try encoder.encode(todo)
        return try JSONSerialization.jsonObject(with: data)
    }

    private func decodeData(_ json: [String: Any]) throws -> [ToDoDTO] {
        try json.map { try decodeData($0.value) }
    }

    private func decodeData(_ json: Any) throws -> ToDoDTO {
        let data = try JSONSerialization.data(withJSONObject: json)
        return try decoder.decode(ToDoDTO.self, from: data)
    }

    public func removeObservers() {
        databasePath?
            .child(DB.Todo.name)
            .removeAllObservers()
    }

    public func addObservers() {
        databasePath?
            .child(DB.Todo.name)
            .observe(.childAdded, with: addRecord)
    }

    private func addRecord(snapshot: DataSnapshot) {
        guard let json = snapshot.value as? [String: Any] else { return }
        do {
            let records = try decodeData(json)
        } catch {
            print("an error occurred", error)
        }
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
