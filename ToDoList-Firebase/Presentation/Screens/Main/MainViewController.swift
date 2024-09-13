//
//  MainViewController.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 12.09.2024.
//

import UIKit
import Combine

final class MainViewController: BaseViewController {
    private let screen = MainViewScreen()
    private let viewModel: MainViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureViews() {
        addScreen(screen: screen)

        super.configureViews()
        title = R.Strings.titleMain
    }

    override func binding() {
    }

}
