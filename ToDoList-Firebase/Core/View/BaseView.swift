//
//  BaseView.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//


import UIKit

typealias OnClick = () -> Void

class BaseView: UIView {

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureViews()
        configureConstraints()
        configureAppearance()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)

        configureViews()
        configureConstraints()
        configureAppearance()
    }
    
}

@objc extension BaseView {

    func configureViews() {}

    func configureConstraints() {}

    func configureAppearance() {
        backgroundColor = .clear
    }
}
