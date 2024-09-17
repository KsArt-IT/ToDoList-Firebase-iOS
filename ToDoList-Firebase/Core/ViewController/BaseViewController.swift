//
//  NavBarPosition.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import UIKit

class BaseViewController: UIViewController {

    private var _screen: UIView?

    private let loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        configureConstraints()
        configureAppearance()
        binding()
    }
}

// MARK: - Configure Screen
@objc extension BaseViewController {

    func addScreen(screen: UIView) {
        _screen = screen
    }

    func configureViews() {
        guard let _screen else { return }

        view.addSubview(_screen)
        view.addSubview(loader)
    }

    func configureConstraints() {
        guard let _screen else { return }

        _screen.translatesAutoresizingMaskIntoConstraints = false
        loader.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            _screen.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            _screen.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            _screen.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            _screen.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    func configureAppearance() {
        view.backgroundColor = .background
    }

    func binding() {}
}

// MARK: - Show Alert
extension BaseViewController {

    func showLoader(_ show: Bool = true) {
        show ? loader.startAnimating() : loader.stopAnimating()
    }

    func showAlertOk(title: String? = nil, message: String? = nil) {
        guard title != nil || message != nil else { return }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
