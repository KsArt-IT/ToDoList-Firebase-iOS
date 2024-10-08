//
//  LoginViewController.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import UIKit
import Combine
import GoogleSignIn

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
        title = R.Strings.titleLogin
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
            registration: self.viewModel.toRegistration,
            resetPassword: self.viewModel.toResetPassword
        )

        viewModel.$viewStates
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
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
                    case .edit(_):
                        break
                }
            }.store(in: &cancellables)

        viewModel.isLoginButtonEnabled
            .assign(to: \.isLoginButtonEnabled, on: screen)
            .store(in: &cancellables)

        viewModel.$requestLoginGoogle
            .sink { [weak self] clientID in
                guard let clientID else { return }
                self?.showLoginGoogle(clientID)
            }.store(in: &cancellables)

    }

    private func showLoginGoogle(_ clientID: String) {
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn( withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
//                        self.showAlertOk(title: R.Strings.titleError, message: error?.localizedDescription)
                return
            }
            guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }

            self.viewModel.submitLogin(idToken: idToken, accessToken: user.accessToken.tokenString)
        }
    }

    deinit {
        print("LoginViewController.deinit")
    }

}
