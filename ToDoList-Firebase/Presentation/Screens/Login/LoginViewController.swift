//
//  LoginViewController.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import UIKit

class LoginViewController: BaseViewController {
    private let screen = LoginViewScreen()
    private let viewModel: LoginViewModel

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
}
