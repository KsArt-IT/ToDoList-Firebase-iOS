//
//  ToDoItem.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 17.09.2024.
//


import Foundation

struct ToDoDTO: Identifiable, Codable {
    let id: String
    let date: Date
    let title: String
    let text: String
    let isCompleted: Bool
}

extension ToDoDTO {
    func mapToItem() -> ToDoItem {
        ToDoItem(
            id: self.id,
            date: self.date,
            title: self.title,
            text: self.text,
            isCompleted: self.isCompleted
        )
    }
}
