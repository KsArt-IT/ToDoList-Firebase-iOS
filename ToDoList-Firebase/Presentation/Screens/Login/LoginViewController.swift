//
//  LoginViewController.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import UIKit

class LoginViewController: BaseViewController {
    private let screen = LoginViewScreen()

    override func configureViews() {
        addScreen(screen: screen)
        
        super.configureViews()
    }
}
