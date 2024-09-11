//
//  ResetViewScreen.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 10.09.2024.
//

import UIKit
import Combine

final class ResetViewScreen: BaseView {

    private let logo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "LoginLogo")
        view.contentMode = .scaleAspectFit
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.masksToBounds = false
        view.layer.cornerRadius = Constants.sizeLogo / 2
        view.clipsToBounds = true
        return view
    }()
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
        addSubview(logo)
        addSubview(loginTextField)
        addSubview(resetButton)

        resetButton.addTarget(self, action: #selector(clickButton(sender:)), for: .touchUpInside)
    }

    override func configureConstraints() {
        super.configureConstraints()

        logo.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logo.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.medium),
            logo.widthAnchor.constraint(equalToConstant: Constants.sizeLogo),
            logo.heightAnchor.constraint(equalToConstant: Constants.sizeLogo),

            loginTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.medium),
            loginTextField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: Constants.medium),
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
