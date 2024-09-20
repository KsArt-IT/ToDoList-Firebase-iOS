//
//  DateExt.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 20.09.2024.
//

import Foundation

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = R.Strings.dateTimeFormat
    return formatter
}()

extension Date {
    func toStringDateTime() -> String {
        dateFormatter.string(from: self)
    }
}
