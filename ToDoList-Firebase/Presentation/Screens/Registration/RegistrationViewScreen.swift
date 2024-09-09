//
//  LoginViewScreen.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 09.09.2024.
//


import UIKit
import Combine

class RegistrationViewScreen: BaseView {

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
    private let passwordConfirmTextField: TextFieldView = {
        let view = TextFieldView()
        view.keyboardType = .alphabet
        view.isSecureTextEntry = true
        view.titleText = R.Strings.passwordConfirm
        view.placeholderText = R.Strings.passwordPlaceholder
        view.borderWidth = Constants.borderWidth
        view.borderCornerRadius = Constants.cornerRadius
        return view
    }()
    private let registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.Strings.registrationButton, for: .normal)
        button.configuration = UIButton.Configuration.filled()
        return button
    }()

    typealias OnClick = () -> Void
    private var clickRegistration: OnClick?

    public var onEmailTextChange: AnyPublisher<String, Never> {
        loginTextField.textPublisher
    }

    public var onPasswordTextChange: AnyPublisher<String, Never> {
        passwordTextField.textPublisher
    }

    public var onPasswordConfirmTextChange: AnyPublisher<String, Never> {
        passwordConfirmTextField.textPublisher
    }

    @Published public var isButtonEnabled = false {
        didSet {
            registrationButton.isEnabled = isButtonEnabled
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
        passwordConfirmTextField.helperText = message
    }

    public func onClickButtons(_ onClick: @escaping OnClick) {
        self.clickRegistration = onClick
    }

    @objc private func clickButton(sender: UIButton) {
        clickRegistration?()
    }

}

extension RegistrationViewScreen {

    override func configureViews() {
        super.configureViews()
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(passwordConfirmTextField)
        addSubview(registrationButton)

        registrationButton.addTarget(self, action: #selector(clickButton(sender:)), for: .touchUpInside)
    }

    override func configureConstraints() {
        super.configureConstraints()

        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordConfirmTextField.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            loginTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.medium),
            loginTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.medium),

            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: Constants.medium),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.medium),

            passwordConfirmTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            passwordConfirmTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Constants.medium),
            passwordConfirmTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.medium),

            registrationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            registrationButton.topAnchor.constraint(equalTo: passwordConfirmTextField.bottomAnchor, constant: Constants.large),
            registrationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.medium),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .magenta
        loginTextField.titleBackgroundColor = .magenta
        passwordTextField.titleBackgroundColor = .magenta
        passwordConfirmTextField.titleBackgroundColor = .magenta
    }
}
