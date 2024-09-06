//
//  LoginView.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import UIKit

class LoginViewScreen: BaseView {

    private let loginTextField: TextFieldView = {
        let view = TextFieldView()
        view.keyboardType = .emailAddress
        view.titleText = R.Strings.email
        view.placeholderText = R.Strings.emailPlaceholder
        view.borderWidth = Constants.borderWidth
        view.borderCornerRadius = Constants.cornerRadius
        return view
    }()
    private let passwordTextField: TextFieldView = {
        let view = TextFieldView()
        view.keyboardType = .alphabet
        view.isSecureTextEntry = true
        view.titleText = R.Strings.password
        view.placeholderText = R.Strings.passwordPlaceholder
        view.borderWidth = Constants.borderWidth
        view.borderCornerRadius = Constants.cornerRadius
        return view
    }()
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.Strings.loginButton, for: .normal)
        button.configuration = UIButton.Configuration.filled()
        return button
    }()
    private let loginGoogleButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.Strings.loginGoogleButton, for: .normal)
        button.configuration = UIButton.Configuration.filled()
        return button
    }()
    private let registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.Strings.registrationButton, for: .normal)
        button.configuration = UIButton.Configuration.tinted()
        return button
    }()

    typealias OnLoginClick = ((login: String, password: String)) -> Void
    private var clickLogin: OnLoginClick?

    public func onLoginClick(onClick: @escaping OnLoginClick) {
        self.clickLogin = onClick
    }

    @objc private func clickLoginButton() {
        clickLogin?((login: loginTextField.text ?? "", password: passwordTextField.text ?? ""))
    }
}

extension LoginViewScreen {

    override func configureViews() {
        super.configureViews()
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(loginGoogleButton)
        addSubview(registrationButton)

        loginButton.addTarget(self, action: #selector(clickLoginButton), for: .touchUpInside)
    }

    override func configureConstraints() {
        super.configureConstraints()

        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginGoogleButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            loginTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.medium),
            loginTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.medium),

            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: Constants.medium),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.medium),

            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Constants.large),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.medium),

            loginGoogleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            loginGoogleButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: Constants.large),
            loginGoogleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.medium),

            registrationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            registrationButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.large),
            registrationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.medium),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .blue
        loginTextField.titleBackgroundColor = .blue
        passwordTextField.titleBackgroundColor = .blue
        passwordTextField.isSecureTextEntry = true
    }
}
