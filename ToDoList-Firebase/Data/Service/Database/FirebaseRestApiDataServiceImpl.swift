//
//  FirebaseDataServiceImpl.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import Foundation
import Combine

final class FirebaseRestApiDataServiceImpl: DataService {
    private let todoSubject = PassthroughSubject<ToDoDTO, Never>()
    //
    private let session = URLSession.shared

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    // MARK: - To-Do
    public func loadData() async -> Result<[ToDoDTO], Error>  {
        guard let user = UserData.shared.user else { return .failure(NetworkServiceError.cancelled) }
        guard let url = RestApi.getUrl(.todos, uid: user.id, token: user.token) else { return .failure(NetworkServiceError.invalidRequest) }

        do {
            let (json, response) = try await session.data(from: url)
            print("response=\(response)")
            guard checkResponse(response) else {
                return .failure(NetworkServiceError.invalidResponse)
            }
            let data = try decoder.decode([String: ToDoDTO].self, from: json)
            let todos: [ToDoDTO] = Array(data.values)
            return .success(todos)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    public func saveData(todo: ToDoDTO) async -> Result<Bool, Error> {
        guard let user = UserData.shared.user else { return .failure(NetworkServiceError.cancelled) }
        guard let url = RestApi.getUrl(.todo(id: todo.id), uid: user.id, token: user.token) else { return .failure(NetworkServiceError.invalidRequest) }

        do {
            let data = try encoder.encode(todo)

            var request = URLRequest(url: url)
            request.httpMethod = RestApi.Metod.put
            request.httpBody = data

            let (_, response) = try await session.data(for: request)
            guard checkResponse(response) else {
                return .failure(NetworkServiceError.invalidResponse)
            }

            addOrChangeRecord(todo)
            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    public func updateData(todo: ToDoDTO) async -> Result<Bool, Error> {
        guard let user = UserData.shared.user else { return .failure(NetworkServiceError.cancelled) }
        guard let url = RestApi.getUrl(.todo(id: todo.id), uid: user.id, token: user.token) else { return .failure(NetworkServiceError.invalidRequest) }

        do {
            let data = try encoder.encode(todo)

            var request = URLRequest(url: url)
            request.httpMethod = RestApi.Metod.patch // обновление данных
            request.httpBody = data

            let (_, response) = try await session.data(for: request)
            guard checkResponse(response) else {
                return .failure(NetworkServiceError.invalidResponse)
            }

            addOrChangeRecord(todo)
            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    public func deleteData(id: String) async -> Result<Bool, Error> {
        guard let user = UserData.shared.user else { return .failure(NetworkServiceError.cancelled) }
        guard let url = RestApi.getUrl(.todo(id: id), uid: user.id, token: user.token) else { return .failure(NetworkServiceError.invalidRequest) }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = RestApi.Metod.delete

            let (_, response) = try await session.data(for: request)
            guard checkResponse(response) else {
                return .failure(NetworkServiceError.invalidResponse)
            }

            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    // MARK: - User
    public func createUser(user: UserAuth) async -> Result<Bool, Error> {
        guard let url = RestApi.getUrl(.users, uid: user.id, token: user.token) else { return .failure(NetworkServiceError.invalidRequest) }

        do {
            let sendData = [
                "name": user.name,
                "email": user.email,
                "photoUrl": user.photoUrl,
                "last": user.date.ISO8601Format()
            ]
            let data = try encoder.encode(sendData)

            var request = URLRequest(url: url)
            request.httpMethod = RestApi.Metod.put
            request.httpBody = data

            let (_, response) = try await session.data(for: request)
            guard checkResponse(response) else {
                return .failure(NetworkServiceError.invalidResponse)
            }

            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    public func updateUser(user: UserAuth) async -> Result<Bool, Error> {
        guard let url = RestApi.getUrl(.users, uid: user.id, token: user.token) else { return .failure(NetworkServiceError.invalidRequest) }

        do {
            let sendData = [
                "name": user.name,
                "email": user.email,
                "photoUrl": user.photoUrl,
                "last": user.date.ISO8601Format()
            ]
            let data = try encoder.encode(sendData)

            var request = URLRequest(url: url)
            request.httpMethod = RestApi.Metod.patch
            request.httpBody = data

            let (_, response) = try await session.data(for: request)
            guard checkResponse(response) else {
                return .failure(NetworkServiceError.invalidResponse)
            }

            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    public func deleteUser(user: UserAuth) async -> Result<Bool, Error> {
        guard let url = RestApi.getUrl(.users, uid: user.id, token: user.token) else { return .failure(NetworkServiceError.invalidRequest) }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = RestApi.Metod.delete

            let (_, response) = try await session.data(for: request)
            guard checkResponse(response) else {
                return .failure(NetworkServiceError.invalidResponse)
            }

            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    private func checkResponse(_ response: URLResponse) -> Bool {
        if let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode { true } else { false }
    }

    // MARK: - Observe
    public func getTodoPublisher() -> AnyPublisher<ToDoDTO, Never> {
        todoSubject.eraseToAnyPublisher()
    }

    private func addOrChangeRecord(_ todo: ToDoDTO) {
        // публикуем
        todoSubject.send(todo)
    }

}
// правила
/*
{
   "rules": {
     "users": {
       "$uid": {
           ".read": "auth != null && auth.uid === $uid",
           ".write": "auth != null && auth.uid === $uid"
       }
     },
     "todo": {
       "$uid": {
           ".read": "auth != null && auth.uid === $uid",
           ".write": "auth != null && auth.uid === $uid"
       }
     }
   }
}
*/
