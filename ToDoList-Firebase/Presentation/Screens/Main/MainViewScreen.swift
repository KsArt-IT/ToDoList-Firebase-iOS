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
    // pull to refresh
    private let refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.attributedTitle = R.Strings.updatingTable
        return view
    }()
    private var updateData: (() -> Void)?

    public func configureSource(dataSource: UITableViewDataSource, delegate: UITableViewDelegate, update: @escaping () -> Void) {
        self.toDoTableView.delegate = delegate
        self.toDoTableView.dataSource = dataSource
        self.updateData = update
    }

    public func reloadData() {
        toDoTableView.reloadData()
    }

    public func refresh(_ show: Bool = true) {
        show ? refreshControl.beginRefreshing() : refreshControl.endRefreshing()
    }

    @objc private func refreshData() {
        self.updateData?()
    }
}

extension MainViewScreen {

    override func configureViews() {
        super.configureViews()

        toDoTableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.indentifier)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        toDoTableView.refreshControl = refreshControl
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
