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

    private let addButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.titleLabel?.text = R.Strings.addToDoButton
        button.titleLabel?.textColor = .black
        return button
    }()

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureViews() {
        addScreen(screen: screen)

        super.configureViews()
        title = R.Strings.titleMain

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

        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        navigationItem.rightBarButtonItems?.append(UIBarButtonItem(customView: addButton))
    }

    override func binding() {
    }

    @objc private func addTask() {
        
    }

    @objc private func logout() {
        viewModel.logout()
    }

    deinit {
        print("MainViewController.deinit")
    }
}
