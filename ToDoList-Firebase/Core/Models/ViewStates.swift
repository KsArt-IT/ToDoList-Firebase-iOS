//
//  ViewStates.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 09.09.2024.
//


import Foundation
import Combine

enum ViewStates {
    enum Errors {
        case email
        case password
        case alert
    }
    case success
    case edit(item: ToDoItem)
    case failure(error: Errors, message: String)
    case loading
    case none
}
