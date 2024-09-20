//
//  DataComponent.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 20.09.2024.
//

import Foundation
import NeedleFoundation

class DataComponent: Component<DataRepositoryDependency> {

    var mainComponent: MainComponent {
        MainComponent(parent: self)
    }

    var createComponent: CreateComponent {
        CreateComponent(parent: self)
    }
}
