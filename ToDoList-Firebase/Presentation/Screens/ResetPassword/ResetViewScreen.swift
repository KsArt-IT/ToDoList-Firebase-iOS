//
//  ResetViewScreen.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 10.09.2024.
//

import UIKit
import Combine

final class ResetViewScreen: BaseView {

    private let loginTextField: TextFieldView = {
        let view = TextFieldView()
        view.keyboardType = .emailAddress
        view.titleText = R.Strings.email
        view.placeholderText = R.Strings.emailPlaceholder
        view.borderWidth = Constants.borderWidth
        view.borderCornerRadius = Constants.cornerRadius
        return view
    }()
    private let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.Strings.resetButton, for: .normal)
        button.configuration = UIButton.Configuration.filled()
        return button
    }()

    public var onEmailTextChange: AnyPublisher<String, Never> {
        loginTextField.textPublisher
    }

    private var clickButton: OnClick?

    @Published public var isButtonEnabled = false {
        didSet {
            resetButton.isEnabled = isButtonEnabled
        }
    }

    public func clearError() {
        setEmailError()
    }

    public func setEmailError(_ message: String? = nil) {
        loginTextField.helperText = message
    }

    public func onClickButtons(_ onClick: @escaping OnClick) {
        self.clickButton = onClick
    }

    @objc private func clickButton(sender: UIButton) {
        clickButton?()
    }

}

extension ResetViewScreen {
    override func configureViews() {
        super.configureViews()
        addSubview(loginTextField)
        addSubview(resetButton)

        resetButton.addTarget(self, action: #selector(clickButton(sender:)), for: .touchUpInside)
    }

    override func configureConstraints() {
        super.configureConstraints()

        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            loginTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.medium),
            loginTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.medium),

            resetButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            resetButton.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: Constants.large),
            resetButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.medium),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .yellow
        loginTextField.titleBackgroundColor = .yellow
    }

}
