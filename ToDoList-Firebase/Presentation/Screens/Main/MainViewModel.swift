//
//  MainViewModel.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 12.09.2024.
//

import Foundation

final class MainViewModel: TaskViewModel {

    @Published var viewState: ViewStates = .none

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
            self.loadData()
        } else {
            self.toLogin()
        }
    }

    private func loadData() {
        viewState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            // TODO: загрузка данных
            self?.list = []
            self?.viewState = .success
        }
    }

    public func edit(at index: Int) {
        guard insideOfList(index) else { return }

        toEdit(item: list[index])
    }

    public func getItem(at index: Int) -> ToDoItem? {
        guard insideOfList(index) else { return nil }

        return list[index]
    }

    public func add() {
        toAdd()
    }

    public func rename(at index: Int, title: String, text: String) {
        guard insideOfList(index) else { return }

        change(at: index, title: title)
    }

    public func remove(at index: Int) {
        guard insideOfList(index) else { return }

        list.remove(at: index)
    }

    public func forTomorrow(at index: Int) {
        guard insideOfList(index) else { return }

        var date = list[index].date
        // добавим сутки 24 * 3600
        date.addTimeInterval(Constants.dayInterval)
        change(at: index, date: date)
    }

    func toggle(at index: Int) {
        guard insideOfList(index) else { return }

        change(at: index, isCompleted: !list[index].isCompleted)
    }

    private func change(at index: Int, title: String? = nil, text: String? = nil, date: Date? = nil, isCompleted: Bool? = nil) {
        let oldItem = list[index]
        list[index] = ToDoItem(
            id: oldItem.id,
            date: date ?? oldItem.date,
            title: title ?? oldItem.title,
            text: text ?? oldItem.text,
            isCompleted: isCompleted ?? oldItem.isCompleted
        )
    }

    private func insideOfList(_ index: Int) -> Bool {
        0..<list.endIndex ~= index
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
