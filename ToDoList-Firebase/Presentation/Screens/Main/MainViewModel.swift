//
//  MainViewModel.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 12.09.2024.
//

import Foundation
import Combine

final class MainViewModel: TaskViewModel, ObservableObject {

    @Published var viewState: ViewStates = .none
    private var cancellables: Set<AnyCancellable> = []

    private weak var coordinator: Coordinator?
    private let repository: DataRepository

    private var list: [ToDoItem] = []
    public var count: Int {
        list.count
    }

    init(coordinator: Coordinator, repository: DataRepository) {
        self.coordinator = coordinator
        self.repository = repository
        super.init()

        initialize()
    }

    // проверим пользователь залогинен, если да загрузим данные, иначе переход на экран логина
    private func initialize() {
        if UserData.shared.user != nil {
            // сохраним последний вход в DB
            self.saveLogin()
            // загружаем данные 1 раз
            self.loadData()
            // наблюдаем за добавлением и изменением записей
            self.subscribeData()
        } else {
            self.toLogin()
        }
    }

    private func saveLogin() {
        guard let user = UserData.shared.user else { return }
        launch { [weak self] in
            _ = await self?.repository.updateUser(user: user)
        }
    }

    // MARK: - Local list changes
    public func forTomorrow(at index: Int) {
        guard insideOfList(index) else { return }

        // необходимо установить завтрешний день, а время оставить из даты
        let date = list[index].date

        let currentDate = Date() // Текущая дата
        let calendar = Calendar.current
        if let tomorrow = calendar.date(byAdding: .day, value: 1, to: currentDate) {
            var dateComponents = calendar.dateComponents([.year, .month, .day], from: tomorrow)
            let timeComponents = calendar.dateComponents([.hour, .minute], from: date)
            dateComponents.hour = timeComponents.hour
            dateComponents.minute = timeComponents.minute
            dateComponents.second = 0
            if let updatedDate = calendar.date(from: dateComponents) {
                change(at: index, date: updatedDate, isCompleted: false)
            }
        }
    }

    public func toggle(at index: Int) {
        guard insideOfList(index) else { return }

        change(at: index, isCompleted: !list[index].isCompleted)
    }

    private func change(at index: Int, title: String? = nil, text: String? = nil, date: Date? = nil, isCompleted: Bool? = nil) {
        let item = list[index].copy(
            date: date,
            title: title,
            text: text,
            isCompleted: isCompleted
        )
        // если не изменился, то и не будем менять
        if item != list[index] {
            // обновим локально
            list[index] = item
            // обновим в базе
            change(at: index)
        }
    }

    public func getItem(at index: Int) -> ToDoItem? {
        guard insideOfList(index) else { return nil }

        return list[index]
    }

    private func sortList(_ newList: [ToDoItem]) {
        self.list = newList.sorted { $0.date < $1.date }
        viewState = .success
    }

    private func insideOfList(_ index: Int) -> Bool {
        0..<list.endIndex ~= index
    }

    // MARK: - Load and Save to Database
    public func loadData() {
        launch { [weak self] in
            self?.viewState = .loading
            let result = await self?.repository.loadData()
            switch result {
                case .success(let list):
                    self?.sortList(list)
                case .failure(let error):
                    self?.showError(error: error)
                case .none:
                    self?.viewState = .none
            }
        }
    }

    public func remove(at index: Int) {
        guard insideOfList(index) else { return }

        // обновляем только локально, синхронизацию не делаем
        let item = list.remove(at: index)
        launch { [weak self] in
            self?.viewState = .loading
            let result = await self?.repository.deleteData(id: item.id)
            switch result {
                case .success(_):
                    // удаление в таблице уже произошло, повторно не обновляем
                    self?.viewState = .none
                case .failure(let error):
                    // восстановить элемент и обновить таблицу
                    DispatchQueue.main.async { [weak self] in
                        self?.updateList(item)
                        // отобразить ошибку
                        self?.showError(error: error)
                    }
                case .none:
                    self?.viewState = .none
            }
        }
    }

    private func change(at index: Int) {
        guard insideOfList(index) else { return }

        let item = list[index]
        // обновим в базе
        launch { [weak self] in
            self?.viewState = .loading
            let result = await self?.repository.updateData(todo: item)
            switch result {
                case .success(_):
                    self?.viewState = .none
                case .failure(let error):
                    // отобразить ошибку
                    self?.showError(error: error)
                case .none:
                    self?.viewState = .none
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
            self.logout()
        }
    }

    private func updateList(_ newTodo: ToDoItem) {
        var newList = list.filter { $0.id != newTodo.id }
        newList.append(newTodo)
        sortList(newList)
    }

    private func deleteFromList(_ todo: ToDoItem) {
        // после удаления, не сортируем
        list.removeAll { $0.id == todo.id }
        viewState = .success
    }

    // MARK: - Monitoring changes in the database
    private func subscribeData() {
        // для добавления и изменения элементов списка
        repository.getTodoPublisher()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] todo in
                self?.updateList(todo)
            }
            .store(in: &cancellables)
    }

    override func onCleared() {
        // Отмена всех подписок
        cancellables.forEach { $0.cancel() }
        super.onCleared()
    }

    deinit {
        print("MainViewModel.deinit")
    }

    // MARK: - Navigate
    public func add() {
        toAdd()
    }

    public func edit(at index: Int) {
        guard insideOfList(index) else { return }

        toEdit(item: list[index])
    }

    public func logout() {
        UserData.shared.isNeedLogout = true
        toLogin()
    }

    private func toLogin() {
        navigate(to: .login)
    }

    private func toAdd() {
        navigate(to: .edit())
    }

    private func toEdit(item: ToDoItem) {
        navigate(to: .edit(item: item))
    }

    private func navigate(to screen: Route) {
        DispatchQueue.main.async { [weak self] in
            self?.coordinator?.navigation(to: screen)
        }
    }

}
