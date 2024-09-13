//
//  DataRepositoryComponent.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import Foundation
import NeedleFoundation

class DataRepositoryComponent: Component<DataRepositoryDependency> {
    private var dataNetworkService: DataService {
        shared { FirebaseDataServiceImpl() }
    }

    public var dataRepository: DataRepository {
        shared { FirebaseDataRepositoryImpl(service: dataNetworkService) }
    }
}
