//
//  ResetViewController.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 10.09.2024.
//

import UIKit
import Combine

final class ResetViewController: BaseViewController {
    private let screen = ResetViewScreen()
    private let viewModel: ResetViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: ResetViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureViews() {
        addScreen(screen: screen)

        super.configureViews()
        title = R.Strings.titleReset
    }

    override func binding() {
        screen.onEmailTextChange
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellables)

        screen.onClickButtons(viewModel.submitResetPassword)

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
                                self?.showAlertOk(message: message)
                            case .alert:
                                self?.showAlertOk(title: R.Strings.titleError, message: message)
                        }
                    case .loading:
                        break
                    case .none:
                        break
                }
            }.store(in: &cancellables)

        viewModel.isValidEmailPublisher
            .assign(to: \.isButtonEnabled, on: screen)
            .store(in: &cancellables)
    }
}
