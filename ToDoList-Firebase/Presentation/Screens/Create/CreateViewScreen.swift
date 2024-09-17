//
//  CreateViewScreen.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 17.09.2024.
//

import UIKit
import Combine

final class CreateViewScreen: BaseView {

    private let titleField: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.placeholder = R.Strings.placeholderTitle
        return view
    }()
    private let textView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = Constants.borderWidth
        view.layer.borderColor = UIColor.yellow.cgColor
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    private let dateField = UITextField()

    public var onTitleChange: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: titleField)
            .map { ($0.object as? UITextField)?.text ?? "" }
            .eraseToAnyPublisher()
    }
    public var onTextChange: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextView.textDidChangeNotification, object: textView)
            .map { ($0.object as? UITextView)?.text ?? "" }
            .eraseToAnyPublisher()
    }
    public var onDateChange: AnyPublisher<Date, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: dateField)
            .map { ($0.object as? UITextField)?.text ?? "" }
            .map { Date() }
            .eraseToAnyPublisher()
    }

    private let createButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.Strings.createButton, for: .normal)
        button.configuration = UIButton.Configuration.filled()
//        button.titleLabel?.textColor = .black
        return button
    }()

    private var clickButton: OnClick?

    public func onClickButtons(_ onClick: @escaping OnClick) {
        self.clickButton = onClick
    }

    @objc private func clickButton(sender: UIButton) {
        clickButton?()
    }

    public func edit(item: ToDoItem) {
        titleField.text = item.title
        textView.text = item.text
    }
}

extension CreateViewScreen {

    override func configureViews() {
        super.configureViews()

        addSubview(titleField)
        addSubview(textView)
        addSubview(dateField)
        addSubview(createButton)

        createButton.addTarget(self, action: #selector(clickButton(sender:)), for: .touchUpInside)
    }

    override func configureConstraints() {
        super.configureConstraints()

        titleField.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        dateField.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.large),
            titleField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.small),
            titleField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.small),

            textView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: Constants.medium),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.small),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.small),
            textView.heightAnchor.constraint(equalToConstant: Constants.heightContent),

            dateField.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: Constants.medium),
            dateField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.small),
            dateField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.small),

            createButton.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: Constants.large),
            createButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.small),
            createButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.small),
        ])
    }

}
