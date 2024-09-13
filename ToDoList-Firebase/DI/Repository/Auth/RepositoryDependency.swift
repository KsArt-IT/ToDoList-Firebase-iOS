//
//  RepositoryDependency.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import Foundation
import NeedleFoundation

protocol RepositoryDependency: Dependency {
    var authRepository: AuthRepository { get }
}
