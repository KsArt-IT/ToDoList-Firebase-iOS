//
//  DB.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 18.09.2024.
//

import Foundation

enum DB {
    static let url = "https://todolist-firebase-9ecf6-default-rtdb.europe-west1.firebasedatabase.app"
    
    enum Todo {
        static let name = "todo"
        
        enum Fields {
            static let date = "date"
        }
    }
}
