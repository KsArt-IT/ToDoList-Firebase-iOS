//
//  UserData.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import Foundation

final class UserData {
    public static let shared = UserData(); private init() {}

    private var _user: UserAuth?

    public var user: UserAuth? {
        get {
            isNeedLogout ? nil : _user
        }
        set {
            _user = newValue
            isNeedLogout = false
        }
    }

    public var isNeedLogout = false
}
