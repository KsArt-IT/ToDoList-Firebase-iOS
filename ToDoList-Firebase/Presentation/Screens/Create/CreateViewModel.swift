//
//  CreateViewModel.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 17.09.2024.
//

import Foundation

final class CreateViewModel: TaskViewModel {
    @Published var viewState: ViewStates = .none

    private weak var coordinator: Coordinator?
    private let repository: DataRepository

    @Published var date: Date = Date()
    @Published var title = ""
    @Published var text = ""

    init(coordinator: Coordinator, repository: DataRepository, item: ToDoItem?) {
        self.coordinator = coordinator
        self.repository = repository
        super.init()

        initialize(item: item)
    }

    public func create() {
        guard !title.isEmpty, !text.isEmpty else {
            viewState = .failure(error: .alert, message: R.Strings.todoFillFields)
            return
        }

        let todo = ToDoItem(
            id: UUID().uuidString,
            date: self.date,
            title: self.title,
            text: self.text,
            isCompleted: false
        )
        launch { [weak self] in
            self?.viewState = .loading
            let result = await self?.repository.saveData(todo: todo)
            switch result {
                case .success(_):
                    // переходим сразу на основной экран, или необходимо уведомить что все ок?
                    self?.toMain()
                case .failure(let error):
                    let message = if let error = error as? NetworkServiceError { error.localizedDescription
                    } else {
                        error.localizedDescription
                    }
                    self?.viewState = .failure(error: .alert, message: message)
                case .none:
                    break
            }
        }
    }
    // проверим пользователь залогинен, если да загрузим данные, иначе переход на экран логина
    private func initialize(item: ToDoItem?) {
        if UserData.shared.user == nil {
            self.toLogin()
        } else {
            if let item {
                viewState = .edit(item: item)
            }
        }
    }

    deinit {
        print("CreateViewModel.deinit")
    }

    // MARK: - Navigate
    private func toMain() {
        navigate(to: .back)
    }

    private func toLogin() {
        navigate(to: .login)
    }

    private func navigate(to screen: Route) {
        DispatchQueue.main.async { [weak self] in
            self?.coordinator?.navigation(to: screen)
        }
    }

}
