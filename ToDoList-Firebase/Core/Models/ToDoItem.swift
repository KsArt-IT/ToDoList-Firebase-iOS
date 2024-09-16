//
//  ToDoItem.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 16.09.2024.
//

import Foundation

struct ToDoItem: Codable {
    let id: String
    let date: Date
    let title: String
    let text: String
    let isCompleted: Bool
}

class ToDoList {
    static let shared = ToDoList(); private init() {
        list.append(ToDoItem(id: "1", date: Date().addingTimeInterval(Constants.hourInterval), title: "Start", text: "Очень длинное описание на много строк и больше, наверно даже обрежет текст, а может и нет, видно потом будет.", isCompleted: false))
        list.append(ToDoItem(id: "2", date: Date().addingTimeInterval(Constants.dayInterval), title: "Next", text: "Небольшое описание", isCompleted: false))
        list.append(ToDoItem(id: "3", date: Date().addingTimeInterval(-Constants.dayInterval), title: "Now", text: "Описание на пару строк, не более, да две строки", isCompleted: false))
        list.append(ToDoItem(id: "4", date: Date().addingTimeInterval(Constants.dayInterval), title: "Tomorow", text: "Отдых", isCompleted: false))
        list.append(ToDoItem(id: "5", date: Date().addingTimeInterval(-Constants.dayInterval), title: "Start", text: "Очень длинное описание на много строк и больше, наверно даже обрежет текст, а может и нет, видно потом будет.", isCompleted: false))
        list.append(ToDoItem(id: "6", date: Date().addingTimeInterval(-Constants.dayInterval), title: "Next", text: "Небольшое описание", isCompleted: false))
        list.append(ToDoItem(id: "7", date: Date().addingTimeInterval(Constants.dayInterval*2), title: "Now", text: "Описание на пару строк, не более, да две строки", isCompleted: false))
        list.append(ToDoItem(id: "8", date: Date().addingTimeInterval(Constants.dayInterval), title: "Tomorow", text: "Купить хлеб", isCompleted: false))
        list.append(ToDoItem(id: "9", date: Date(), title: "Start", text: "Очень длинное описание на много строк и больше, наверно даже обрежет текст, а может и нет, видно потом будет.", isCompleted: false))
        list.append(ToDoItem(id: "10", date: Date(), title: "Next", text: "Небольшое описание", isCompleted: false))
        list.append(ToDoItem(id: "11", date: Date(), title: "Now", text: "Описание на пару строк, не более, да две строки", isCompleted: false))
        list.append(ToDoItem(id: "12", date: Date().addingTimeInterval(Constants.dayInterval*3), title: "Tomorow", text: "Выкинуть мусор", isCompleted: false))
    }

    var list: [ToDoItem] = []
}
