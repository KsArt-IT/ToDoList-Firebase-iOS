//
//  CreateViewController.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 17.09.2024.
//

import UIKit
import Combine

final class CreateViewController: BaseViewController {
    private let screen = CreateViewScreen()
    private let viewModel: CreateViewModel
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: CreateViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("CreateViewController.deinit")
    }

}

extension CreateViewController {

    override func configureViews() {
        addScreen(screen: screen)

        super.configureViews()
        title = R.Strings.titleCreate

        screen.onClickButtons(self.viewModel.save)
    }

    override func binding() {
        screen.onTitleChange
            .assign(to: \.title, on: viewModel)
            .store(in: &cancellables)
        screen.onTextChange
            .assign(to: \.text, on: viewModel)
            .store(in: &cancellables)
        screen.onDateChange
            .assign(to: \.date, on: viewModel)
            .store(in: &cancellables)

        viewModel.$viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.showLoader(false)

                switch state {
                    case .success:
                        break
                    case .edit(let item):
                        self?.screen.edit(item: item)
                    case let .failure(_, message):
                        self?.showAlertOk(title: R.Strings.titleError, message: message)
                    case .loading:
                        self?.showLoader()
                    case .none:
                        break
                }
            }.store(in: &cancellables)
    }

}
