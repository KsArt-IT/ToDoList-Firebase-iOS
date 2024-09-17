//
//  DataRepository.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import Foundation

protocol DataRepository {
    func saveToDo(_ todo: ToDoItem) async -> Result<Bool, Error>
}
