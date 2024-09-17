//
//  ToDoItem.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 16.09.2024.
//

import Foundation

struct ToDoItem {
    let id: String
    let date: Date
    let title: String
    let text: String
    let isCompleted: Bool
}

extension ToDoItem {
    func mapToDto() -> ToDoDTO {
        ToDoDTO(
            id: self.id,
            date: self.date,
            title: self.title,
            text: self.text,
            isCompleted: self.isCompleted
        )
    }
}
