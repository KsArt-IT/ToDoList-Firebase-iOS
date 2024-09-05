//
//  NavBarPosition.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import UIKit

open class BaseViewController: UIViewController {

    var screen: BaseView = BaseView()

    open override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        configureConstraints()
        configureAppearance()
    }
}

@objc extension BaseViewController {

    func configureViews() {
        view.addSubview(screen)
    }

    func configureConstraints() {

        screen.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            screen.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            screen.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            screen.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func configureAppearance() {
        view.backgroundColor = .background
    }

}
