//
//  LoginViewController.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import UIKit
import Combine

class LoginViewController: BaseViewController {
    private let screen = LoginViewScreen()
    private let viewModel: LoginViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureViews() {
        addScreen(screen: screen)

        super.configureViews()
    }

    override func configureAppearance() {
        super.configureAppearance()
    }

    override func binding() {
        screen.onEmailTextChange
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellables)

        screen.onPasswordTextChange
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)

        screen.onClickButtons(
            login: self.viewModel.submitLogin,
            loginGoogle: self.viewModel.toLoginGoogle,
            registration: self.viewModel.toRegistration
        )

        viewModel.$viewStates.sink { [weak self] state in
            self?.screen.clearError()
            switch state {
                case .success:
                    break
                case .failure(let error, let message):
                    switch error {
                        case .email:
                            self?.screen.setEmailError(message)
                        case .password:
                            self?.screen.setPasswordError(message)
                        case .alert:
                            self?.showAlertOk(title: R.Strings.titleError, message: message)
                    }
                case .loading:
                    break
                case .none:
                    break
            }
        }.store(in: &cancellables)

        viewModel.isLoginButtonEnabled.sink { [weak self] isEnabled in
            self?.screen.setLoginButton(on: isEnabled)
        }.store(in: &cancellables)
    }
}
