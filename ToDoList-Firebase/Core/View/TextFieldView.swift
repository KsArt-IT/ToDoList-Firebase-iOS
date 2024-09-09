//
//  TextFieldView.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 06.09.2024.
//

import UIKit
import Combine

final class TextFieldView: BaseView {

    // рамка
    private let backgroundView = UIView()
    // название поля
    private let titleLabel = UILabel()
    // фон для названия
    private let titleView = UIView()
    // левая начальная иконка
    private let leftIcon = UIImageView()
    private let rightIcon = UIImageView()
    // поле для ввода
    private let textField = UITextField()
    // подсказка внизу или ошибка
    private let helperLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: -1)
        view.numberOfLines = 3
        return view
    }()
    private var isError: Bool = false {
        didSet {
            updateAppearance()
        }
    }

    private let disabledAlpha: CGFloat = 0.3

    // MARK: - Поля
    public var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: textField)
            .map { ($0.object as? UITextField)?.text ?? "" }
            .eraseToAnyPublisher()
    }

    var text: String? {
        get {
            self.textField.text
        }
        set {
            self.textField.text = newValue
        }
    }

    var isSecureTextEntry: Bool {
        get {
            self.textField.isSecureTextEntry
        }
        set {
            self.textField.isSecureTextEntry = newValue
        }
    }

    var keyboardType: UIKeyboardType {
        get {
            self.textField.keyboardType
        }
        set {
            self.textField.keyboardType = newValue
        }
    }

    var isEnabled: Bool = true {
        didSet {
            updateAppearance()
        }
    }

    var titleText: String? {
        didSet {
            self.titleLabel.text = titleText
            self.titleLabel.isHidden = titleText == ""
            self.titleView.isHidden = self.titleLabel.isHidden
        }
    }

    var titleBackgroundColor: UIColor = .white {
        didSet {
            self.titleView.backgroundColor = titleBackgroundColor != .clear ? titleBackgroundColor : .white
        }
    }

    var helperText: String? {
        didSet {
            self.helperLabel.text = helperText
            self.helperLabel.isHidden = helperText == ""
        }
    }

    var placeholderText: String? {
        didSet {
            self.textField.placeholder = placeholderText
        }
    }

    var placeholderColor: UIColor = .black {
        didSet {
            setPlaceholderColor()
        }
    }

    var backgroundColorView: UIColor = .clear {
        didSet {
            self.backgroundView.backgroundColor = backgroundColorView
        }
    }

    var borderCornerRadius: CGFloat {
        get {
            self.backgroundView.layer.cornerRadius
        }
        set {
            self.backgroundView.layer.cornerRadius = max(newValue, 0)
            self.backgroundView.layer.masksToBounds = self.backgroundView.layer.cornerRadius > 0
        }
    }

    var borderWidth: CGFloat {
        get {
            self.backgroundView.layer.borderWidth
        }
        set {
            self.backgroundView.layer.borderWidth = max(newValue, 0)
        }
    }

    var borderColor: UIColor = .clear {
        didSet {
            self.backgroundView.layer.borderColor = borderColor.cgColor
            self.titleLabel.textColor = getTitleColor()
        }
    }

    var leftImage: UIImage? {
        didSet {
            self.leftIcon.image = leftImage
            self.leftIcon.isHidden = leftImage == nil
        }
    }

    var leftImageColor: UIColor = .black {
        didSet {
            self.leftIcon.tintColor = leftImageColor
            self.leftIcon.backgroundColor = .clear
        }
    }

    var rightImage: UIImage? {
        didSet {
            self.rightIcon.image = rightImage
            self.rightIcon.isHidden = rightImage == nil
        }
    }

    var rightImageColor: UIColor = .black {
        didSet {
            self.rightIcon.tintColor = rightImageColor
            self.rightIcon.backgroundColor = .clear
        }
    }

}

extension TextFieldView {

    override func configureViews() {
        super.configureViews()
        addSubview(backgroundView)

        addSubview(titleView)
        addSubview(titleLabel)

        addSubview(leftIcon)
        addSubview(rightIcon)

        addSubview(helperLabel)

        addSubview(textField)
    }

    override func configureConstraints() {
        let small: CGFloat = 8
        let sizeIcon: CGFloat = 24
        let labelOffset: CGFloat = borderCornerRadius * 2 + small * 2
        print(labelOffset)

        let textFieldLeadingAnchor = leftIcon.image != nil ? leftIcon.trailingAnchor : self.leadingAnchor
        let textFieldTrailingAnchor = rightIcon.image != nil ? rightIcon.leadingAnchor : self.trailingAnchor
        let textFieldLeadingConstant: CGFloat = leftIcon.image == nil && borderCornerRadius > 0 ? borderCornerRadius : small
        let textFieldTrailingConstant: CGFloat = rightIcon.image == nil && borderCornerRadius > 0 ? borderCornerRadius : small

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        leftIcon.translatesAutoresizingMaskIntoConstraints = false
        rightIcon.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        helperLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Top label constraints
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: labelOffset),

            titleView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            titleView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            titleView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -small),
            titleView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: small),

            // Left image view constraints
            leftIcon.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            leftIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: small),
            leftIcon.heightAnchor.constraint(equalToConstant: sizeIcon),
            leftIcon.widthAnchor.constraint(equalToConstant: sizeIcon),

            // TextField constraints
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: small),
            textField.leadingAnchor.constraint(equalTo: textFieldLeadingAnchor, constant: textFieldLeadingConstant),
            textField.trailingAnchor.constraint(equalTo: textFieldTrailingAnchor, constant: -textFieldTrailingConstant),

            // Right image view constraints
            rightIcon.centerYAnchor.constraint(equalTo: self.textField.centerYAnchor),
            rightIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -small),
            rightIcon.heightAnchor.constraint(equalToConstant: sizeIcon),
            rightIcon.widthAnchor.constraint(equalToConstant: sizeIcon),

            // Background view constraints
            backgroundView.topAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: small),

            // Helper label constraints
            helperLabel.topAnchor.constraint(equalTo: self.backgroundView.bottomAnchor),
            helperLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: small),
            helperLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -small),
            helperLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        self.frame = CGRect(
            x: frame.minX, y: frame.minY, width: frame.width,
            height: helperLabel.frame.minY - titleLabel.frame.minY + helperLabel.frame.height
        )
    }

    private func setupAppearance() {
        updateAppearance()

        leftIcon.contentMode = .scaleAspectFit
        leftIcon.isHidden = leftIcon.image == nil

        rightIcon.contentMode = .scaleAspectFit
        rightIcon.isHidden = rightIcon.image == nil

        titleLabel.isHidden = titleText == ""
        titleLabel.textColor = borderColor != .clear ? borderColor : .black

        titleView.backgroundColor = titleBackgroundColor
        titleView.isHidden = titleLabel.isHidden

        helperLabel.isHidden = helperText == ""
        helperLabel.textColor = .darkGray

        textField.textColor = .black
        textField.borderStyle = .none

        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.autoresizesSubviews = true
    }

    private func updateAppearance() {
        let color: UIColor = isError ? .red : self.titleLabel.textColor
        let borderColor: UIColor = isError ? .red : self.borderColor

        titleLabel.isEnabled = isEnabled
        titleLabel.textColor = getTitleColor()

        textField.isEnabled = isEnabled
        setPlaceholderColor()

        helperLabel.isEnabled = isEnabled

        if !isEnabled {
            backgroundView.backgroundColor = backgroundColorView.withAlphaComponent(disabledAlpha)
            backgroundView.layer.borderColor = borderColor.withAlphaComponent(disabledAlpha).cgColor

            leftIcon.tintColor = color.withAlphaComponent(disabledAlpha)
            rightIcon.tintColor = color.withAlphaComponent(disabledAlpha)
        } else {
            backgroundView.backgroundColor = backgroundColorView
            backgroundView.layer.borderColor = borderColor.cgColor

            leftIcon.tintColor = color
            rightIcon.tintColor = color
        }
    }

    private func setPlaceholderColor() {
        self.textField.attributedPlaceholder = placeholderText == nil ? nil : NSAttributedString(
            string: placeholderText ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor.withAlphaComponent(0.5)]
        )
    }

    private func getTitleColor() -> UIColor {
        var color = borderColor != .clear ? borderColor : .black
        color = isError ? .red : color
        return isEnabled ? color : color.withAlphaComponent(disabledAlpha)
    }

}
