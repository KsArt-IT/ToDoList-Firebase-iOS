//
//  DataRepository.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import Foundation
import Combine

protocol DataRepository {
    func loadData() async -> Result<[ToDoItem], Error>
    func saveData(todo: ToDoItem) async -> Result<Bool, Error>
    func updateData(todo: ToDoItem) async -> Result<Bool, Error>
    func deleteData(id: String) async -> Result<Bool, Error>
    func updateUser(user: UserAuth) async -> Result<Bool, Error>

    func getTodoPublisher() -> AnyPublisher<ToDoItem, Never>
}
