//
//  LoginView.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import UIKit
import Combine

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
    private let resetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.Strings.passwordForgot, for: .normal)
        button.configuration = UIButton.Configuration.tinted()
        return button
    }()

    typealias OnClick = () -> Void
    private var clickLogin: OnClick?
    private var clickLoginGoogle: OnClick?
    private var clickRegistration: OnClick?
    private var clickResetPassword: OnClick?

    private var cancellables = Set<AnyCancellable>()

    public var onEmailTextChange: AnyPublisher<String, Never> {
        loginTextField.textPublisher
    }

    public var onPasswordTextChange: AnyPublisher<String, Never> {
        passwordTextField.textPublisher
    }

    @Published public var isLoginButtonEnabled = false {
        didSet {
            loginButton.isEnabled = isLoginButtonEnabled
        }
    }

    public func clearError() {
        setEmailError()
        setPasswordError()
    }

    public func setEmailError(_ message: String? = nil) {
        loginTextField.helperText = message
    }

    public func setPasswordError(_ message: String? = nil) {
        passwordTextField.helperText = message
    }

    public func onClickButtons(login: @escaping OnClick, loginGoogle: @escaping OnClick, registration: @escaping OnClick, resetPassword: @escaping OnClick) {
        self.clickLogin = login
        self.clickLoginGoogle = loginGoogle
        self.clickRegistration = registration
        self.clickResetPassword = resetPassword
    }

    @objc private func clickButton(sender: UIButton) {
        switch sender {
            case loginButton:
                clickLogin?()
            case loginGoogleButton:
                clickLoginGoogle?()
            case registrationButton:
                clickRegistration?()
            case resetPasswordButton:
                clickResetPassword?()
            default:
                break
        }
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
        addSubview(resetPasswordButton)

        loginButton.addTarget(self, action: #selector(clickButton(sender:)), for: .touchUpInside)
        loginGoogleButton.addTarget(self, action: #selector(clickButton(sender:)), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(clickButton(sender:)), for: .touchUpInside)
        resetPasswordButton.addTarget(self, action: #selector(clickButton(sender:)), for: .touchUpInside)
    }

    override func configureConstraints() {
        super.configureConstraints()

        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginGoogleButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            loginTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.medium),
            loginTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.medium),

            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: Constants.medium),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.medium),

            resetPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Constants.medium),
            resetPasswordButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.medium),

            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            loginButton.topAnchor.constraint(equalTo: resetPasswordButton.bottomAnchor, constant: Constants.medium),
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
    }
}
