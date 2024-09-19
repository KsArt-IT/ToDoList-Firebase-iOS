//
//  DataRepository.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import Foundation

protocol DataRepository {
    func loadData() async -> Result<[ToDoItem], Error>
    func saveData(todo: ToDoItem) async -> Result<Bool, Error>
    func updateData(todo: ToDoItem) async -> Result<Bool, Error>
    func deleteData(id: String) async -> Result<Bool, Error>
    func addObservers()
    func removeObservers()
}
