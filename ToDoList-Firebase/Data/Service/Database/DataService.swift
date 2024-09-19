//
//  DataService.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import Foundation

protocol DataService {
    func loadData() async -> Result<[ToDoDTO], Error>
    func saveData(todo: ToDoDTO) async -> Result<Bool, Error>
    func updateData(todo: ToDoDTO) async -> Result<Bool, Error>
    func deleteData(id: String) async -> Result<Bool, Error>
    func addObservers()
    func removeObservers()
}
