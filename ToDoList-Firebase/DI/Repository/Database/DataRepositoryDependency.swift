//
//  RepositoryDependency.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import Foundation
import NeedleFoundation

protocol DataRepositoryDependency: Dependency {
    var dataRepository: DataRepository { get }
}
