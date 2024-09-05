//
//  NavBarPosition.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import UIKit

class BaseViewController: UIViewController {

    private var _screen: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        configureConstraints()
        configureAppearance()
    }
}

@objc extension BaseViewController {

    func addScreen(screen: UIView) {
        _screen = screen
    }
    
    func configureViews() {
        if let _screen {
            view.addSubview(_screen)
        }
    }

    func configureConstraints() {
        if let _screen {
            _screen.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                _screen.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                _screen.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                _screen.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                _screen.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        }
    }

    func configureAppearance() {
        view.backgroundColor = .background
    }

}
