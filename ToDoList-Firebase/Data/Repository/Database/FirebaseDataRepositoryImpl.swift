//
//  DataRepositoryImpl.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import Foundation

final class FirebaseDataRepositoryImpl: DataRepository {

    private let service: DataService

    init(service: DataService) {
        self.service = service
    }

}
