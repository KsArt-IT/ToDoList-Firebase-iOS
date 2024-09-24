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
        guard let url = RestApi.getUrl(.todos, uid: user.id, token: user.token) else {
            return .failure(NetworkServiceError.invalidRequest)
        }

        do {
            let (data, response) = try await session.data(from: url)
            guard checkResponse(response) else {
                return .failure(NetworkServiceError.invalidResponse)
            }
            let todos = try decoder.decode([String: ToDoDTO].self, from: data)
            return .success(Array(todos.values))
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    public func saveData(todo: ToDoDTO) async -> Result<Bool, Error> {
        guard let user = UserData.shared.user else { return .failure(NetworkServiceError.cancelled) }
        guard let url = RestApi.getUrl(.todo(id: todo.id), uid: user.id, token: user.token) else {
            return .failure(NetworkServiceError.invalidRequest)
        }

        do {
            let request = try getRequest(url: url, on: RestApi.Metod.put, for: todo)
            guard try await sendRequest(request) else { return .failure(NetworkServiceError.invalidResponse) }

            addOrChangeRecord(todo)
            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    public func updateData(todo: ToDoDTO) async -> Result<Bool, Error> {
        guard let user = UserData.shared.user else { return .failure(NetworkServiceError.cancelled) }
        guard let url = RestApi.getUrl(.todo(id: todo.id), uid: user.id, token: user.token) else {
            return .failure(NetworkServiceError.invalidRequest)
        }

        do {
            let request = try getRequest(url: url, on: RestApi.Metod.patch, for: todo)
            guard try await sendRequest(request) else { return .failure(NetworkServiceError.invalidResponse) }

            addOrChangeRecord(todo)
            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    public func deleteData(id: String) async -> Result<Bool, Error> {
        guard let user = UserData.shared.user else { return .failure(NetworkServiceError.cancelled) }
        guard let url = RestApi.getUrl(.todo(id: id), uid: user.id, token: user.token) else {
            return .failure(NetworkServiceError.invalidRequest)
        }

        do {
            let request = try getRequest(url: url, on: RestApi.Metod.delete)
            guard try await sendRequest(request) else { return .failure(NetworkServiceError.invalidResponse) }

            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    // MARK: - User
    public func createUser(user: UserAuth) async -> Result<Bool, Error> {
        guard let url = RestApi.getUrl(.users, uid: user.id, token: user.token) else {
            return .failure(NetworkServiceError.invalidRequest)
        }

        do {
            let request = try getRequest(url: url, on: RestApi.Metod.put, for: userData(user))
            guard try await sendRequest(request) else { return .failure(NetworkServiceError.invalidResponse) }

            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    public func updateUser(user: UserAuth) async -> Result<Bool, Error> {
        guard let url = RestApi.getUrl(.users, uid: user.id, token: user.token) else {
            return .failure(NetworkServiceError.invalidRequest)
        }

        do {
            let request = try getRequest(url: url, on: RestApi.Metod.patch, for: userData(user))
            guard try await sendRequest(request) else { return .failure(NetworkServiceError.invalidResponse) }

            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    private func userData(_ user: UserAuth) -> [String: String] {
        [
            RestApi.DB.Users.name: user.name,
            RestApi.DB.Users.email: user.email,
            RestApi.DB.Users.photoUrl: user.photoUrl ?? "",
            RestApi.DB.Users.last: user.date.ISO8601Format()
        ]
    }

    public func deleteUser(user: UserAuth) async -> Result<Bool, Error> {
        guard let url = RestApi.getUrl(.users, uid: user.id, token: user.token) else {
            return .failure(NetworkServiceError.invalidRequest)
        }

        do {
            let request = try getRequest(url: url, on: RestApi.Metod.delete)
            guard try await sendRequest(request) else { return .failure(NetworkServiceError.invalidResponse) }

            return .success(true)
        } catch {
            return .failure(NetworkServiceError.networkError(error))
        }
    }

    // MARK: - Encode - Request - Response
    private func getRequest(url: URL, on httpMethod: String, for data: Encodable? = nil) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod

        if let data {
            request.httpBody = try encoder.encode(data)
        }

        return request
    }

    private func sendRequest(_ request: URLRequest) async throws -> Bool {
        let (_, response) = try await session.data(for: request)
        return checkResponse(response)
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
