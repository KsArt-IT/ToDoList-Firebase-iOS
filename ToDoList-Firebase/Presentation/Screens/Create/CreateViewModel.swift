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
    private let item: ToDoItem?

    @Published var date: Date = Date()
    @Published var title = ""
    @Published var text = ""

    init(coordinator: Coordinator, repository: DataRepository, item: ToDoItem?) {
        self.coordinator = coordinator
        self.repository = repository
        self.item = item
        super.init()

        initialize()
    }

    public func save() {
        guard !title.isEmpty, !text.isEmpty else {
            viewState = .failure(error: .alert, message: R.Strings.todoFillFields)
            return
        }

        launch { [weak self] in
            guard let self else { return }

            self.viewState = .loading
            let result =  if let item = self.item {
                await self.repository.updateData(
                    todo: item.copy(
                        date: self.date,
                        title: self.title,
                        text: self.text
                    )
                )
            } else {
                await self.repository.saveData(
                    todo: ToDoItem(
                        id: UUID().uuidString,
                        date: self.date,
                        title: self.title,
                        text: self.text,
                        isCompleted: false
                    )
                )
            }
            switch result {
                case .success(_):
                    self.viewState = .success
                    // переходим сразу на основной экран, или необходимо уведомить что все ок?
                    self.toMain()
                case .failure(let error):
                    // отобразить ошибку
                    self.showError(error: error)
            }
        }
    }
    // проверим пользователь залогинен, если да загрузим данные, иначе переход на экран логина
    private func initialize() {
        if UserData.shared.user == nil {
            self.toLogin()
        } else {
            if let item = self.item {
                viewState = .edit(item: item)
            }
        }
    }

    private func showError(error: Error) {
        let message = if let error = error as? NetworkServiceError {
            error.localizedDescription
        } else {
            error.localizedDescription
        }
        if !message.isEmpty {
            self.viewState = .failure(error: .alert, message: message)
        } else {
            // релогин
            self.toLogin()
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
