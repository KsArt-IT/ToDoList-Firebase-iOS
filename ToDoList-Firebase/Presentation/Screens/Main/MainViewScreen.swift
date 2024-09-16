//
//  MainViewScreen.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 12.09.2024.
//

import UIKit

final class MainViewScreen: BaseView {

    private let toDoTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()

    public func configureSource(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        self.toDoTableView.delegate = delegate
        self.toDoTableView.dataSource = dataSource
    }

    public func reloadData() {
        toDoTableView.reloadData()
    }
}

extension MainViewScreen {

    override func configureViews() {
        super.configureViews()

        toDoTableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.indentifier)
        addSubview(toDoTableView)
    }

    override func configureConstraints() {
        super.configureConstraints()

        toDoTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            toDoTableView.topAnchor.constraint(equalTo: self.topAnchor),
            toDoTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            toDoTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.small),
            toDoTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.small),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        self.backgroundColor = .clear
        self.toDoTableView.backgroundColor = .clear
    }
}
