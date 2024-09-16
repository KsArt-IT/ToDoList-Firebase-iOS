//
//  MainViewController.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 12.09.2024.
//

import UIKit
import Combine

final class MainViewController: BaseViewController {
    private let screen = MainViewScreen()
    private let viewModel: MainViewModel
    private var cancellables = Set<AnyCancellable>()

    private let addButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.titleLabel?.text = R.Strings.addToDoButton
        button.titleLabel?.textColor = .black
        return button
    }()

    private let loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        return view
    }()

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func showLoader(_ show: Bool = true) {
        show ? loader.startAnimating() : loader.stopAnimating()
    }

    deinit {
        print("MainViewController.deinit")
    }

}

extension MainViewController {

    override func configureViews() {
        addScreen(screen: screen)

        super.configureViews()
        title = R.Strings.titleMain

        screen.configureSource(dataSource: self, delegate: self)
        view.addSubview(loader)

        // добавляем меню для logout
        let menu = UIMenu(
            title: "",
            children: [
                UIAction( title: R.Strings.logoutButton, image: UIImage(systemName: "xmark.circle")) { [weak self] _ in
                    self?.viewModel.logout()
                },
            ]
        )
        let menuBarButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            menu: menu
        )

        navigationItem.rightBarButtonItem = menuBarButton

        // добавляем кнопку добавить элемент
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        navigationItem.rightBarButtonItems?.append(UIBarButtonItem(customView: addButton))
    }

    override func configureConstraints() {
        super.configureConstraints()

        loader.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    override func binding() {
        viewModel.$viewState.receive(on: DispatchQueue.main).sink { [weak self] state in
            self?.showLoader(false)

            switch state {
                case .success:
                    self?.screen.reloadData()
                case let .failure(_, message):
                    self?.showAlertOk(title: R.Strings.titleError, message: message)
                case .loading:
                    self?.showLoader()
                case .none:
                    break
            }
        }.store(in: &cancellables)
    }

    @objc private func addTask() {
        TextPicker().show(in: self) { [weak self] title, text in
            self?.viewModel.add(title: title, text: text)
        }
    }

    @objc private func logout() {
        viewModel.logout()
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.indentifier, for: indexPath) as? ToDoCell else { return UITableViewCell() }

        guard let item = viewModel.getItem(at: indexPath.row) else { fatalError("index not in 0..<\(viewModel.count)")}
        
        cell.configure(item: item)

        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.toggle(at: indexPath.row)

        tableView.reloadRows(at: [indexPath], with: .fade)
    }

    // показывает кнопки с лева, когда свайпим в право
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        // 2 кнопки действий
        let actionRename = UIContextualAction(style: .normal, title: R.Strings.renameAction) { [weak self] _, _, completed in
            guard let self, let item = self.viewModel.getItem(at: indexPath.row) else { return }

            TextPicker().show(in: self, title: item.title, text: item.text) {
                // скрыть кнопку после
                completed(true)
            } complition: { [weak self] title, text in
                self?.viewModel.rename(at: indexPath.row, title: title, text: text)

                // обновить строку
               tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        // цвет фона
        actionRename.backgroundColor = .magenta

        let actionTomorrow = UIContextualAction(style: .normal, title: R.Strings.forTomorrowAction) { [weak self] _, _, completed in
            self?.viewModel.forTomorrow(at: indexPath.row)
            // скрыть кнопку после
            completed(true)
            // обновить строку
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        actionTomorrow.backgroundColor = .blue

        return UISwipeActionsConfiguration(actions: [actionRename, actionTomorrow])
    }

    // показывает кнопки с права, когда свайпим в лево
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        // кнопки действий
        let action = UIContextualAction(style: .destructive, title: R.Strings.deleteAction) { [weak self] _, _, completed in
            self?.viewModel.remove(at: indexPath.row)

            // удалить строку
            tableView.deleteRows(at: [indexPath], with: .automatic)
            // скрыть кнопку после
            completed(true)
        }
        // картинка вместо надписи
        action.image = UIImage(systemName: "trash")

        return UISwipeActionsConfiguration(actions: [action])
    }

}
