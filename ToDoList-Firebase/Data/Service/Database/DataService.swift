//
//  DataService.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import Foundation

protocol DataService {
    func saveData(todo: ToDoDTO) async -> Result<Bool, Error>
}
