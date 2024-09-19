//
//  DataRepositoryImpl.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import Foundation

final class FirebaseDataRepositoryImpl: DataRepository {

    private let service: DataService

    init(service: DataService) {
        self.service = service
    }

    public func loadData() async -> Result<[ToDoItem], Error> {
        let result = await service.loadData()
        return switch result {
            case .success(let list):
                    .success(list.map { $0.mapToItem() })
            case .failure(let error):
                    .failure(error)
        }
    }

    public func saveData(todo: ToDoItem) async -> Result<Bool, Error> {
        await service.saveData(todo: todo.mapToDto())
    }

    public func updateData(todo: ToDoItem) async -> Result<Bool, Error> {
        await service.updateData(todo: todo.mapToDto())
    }

    public func deleteData(id: String) async -> Result<Bool, Error> {
        await service.deleteData(id: id)
    }

    public func addObservers() {
        service.addObservers()
    }

    public func removeObservers() {
        service.removeObservers()
    }
}
