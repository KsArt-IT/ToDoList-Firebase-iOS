//
//  RegistrationViewController.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 09.09.2024.
//

import Foundation
import Combine

final class RegistrationViewController: BaseViewController {
    private let screen = RegistrationViewScreen()
    private let viewModel: RegistrationViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureViews() {
        addScreen(screen: screen)

        super.configureViews()
        title = R.Strings.titleRegistration
    }

    override func binding() {
        screen.onEmailTextChange
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellables)

        screen.onPasswordTextChange
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)

        screen.onPasswordConfirmTextChange
            .assign(to: \.passwordConfirm, on: viewModel)
            .store(in: &cancellables)

        screen.onClickButtons(viewModel.submitRegistration)

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
                }
            }.store(in: &cancellables)

        viewModel.isRegistrationButtonEnabled
            .assign(to: \.isButtonEnabled, on: screen)
            .store(in: &cancellables)
    }
}
