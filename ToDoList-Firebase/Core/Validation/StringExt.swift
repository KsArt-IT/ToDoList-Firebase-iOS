//
//  StringExt.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 09.09.2024.
//

import Foundation

extension String {
    func isEmail() -> Bool {
        !self.isEmpty && EmailValidation.emailPredicat.evaluate(with: self.lowercased())
    }
}

fileprivate class EmailValidation {
    static let emailRegex = "^(?=[a-z0-9][a-z0-9@._%+-]{5,253}$)([a-z0-9_-]+\\.)*[a-z0-9_-]+@[a-z0-9_-]+(\\.[a-z0-9_-]+)*\\.[a-z]{2,63}$"
    static let emailPredicat = NSPredicate(format: "SELF MATCHES %@", emailRegex)
}
