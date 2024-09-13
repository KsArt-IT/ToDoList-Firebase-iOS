//
//  MainViewModel.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 12.09.2024.
//

import Foundation

final class MainViewModel: TaskViewModel {

    private weak var coordinator: Coordinator?
    private let repository: DataRepository

    init(coordinator: Coordinator, repository: DataRepository) {
        self.coordinator = coordinator
        self.repository = repository
        super.init()

        initialize()
    }

    // проверим пользователь залогинен, если да загрузим данные, иначе переход на экран логина
    private func initialize() {
        if UserData.shared.user != nil {
            self.loadData()
        } else {
            self.toLogin()
        }
    }

    private func loadData() {

    }

    public func logout() {
        UserData.shared.isNeedLogout = true
        toLogin()
    }

    deinit {
        print("MainViewModel.deinit")
    }

    // MARK: - Navigate
    private func toLogin() {
        navigate(to: .login)
    }

    private func navigate(to screen: Route) {
        DispatchQueue.main.async { [weak self] in
            self?.coordinator?.navigation(to: screen)
        }
    }

}
