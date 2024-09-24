//
//  CreateViewScreen.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 17.09.2024.
//

import UIKit
import Combine

final class CreateViewScreen: BaseView {

    private let titleWindow: UILabel = {
        let label = UILabel()
        label.text = R.Strings.titleCreate
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    private let titleSubject = PassthroughSubject<String, Never>()
    public var onTitleChange: AnyPublisher<String, Never> {
        titleSubject.eraseToAnyPublisher()
    }
    private let titleField: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.placeholder = R.Strings.placeholderTitle
        view.layer.borderWidth = Constants.borderWidth
        view.layer.borderColor = UIColor.yellow.cgColor
        view.layer.cornerRadius = Constants.cornerRadius
        view.clipsToBounds = true
        return view
    }()
    private let textSubject = PassthroughSubject<String, Never>()
    public var onTextChange: AnyPublisher<String, Never> {
        textSubject.eraseToAnyPublisher()
    }
    private let textView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = Constants.borderWidth
        view.layer.borderColor = UIColor.yellow.cgColor
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = R.Strings.dateTimeFormat
        label.textAlignment = .center
        return label
    }()

    private let dateSubject = PassthroughSubject<Date, Never>()
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        picker.layer.borderWidth = Constants.borderWidth
        picker.layer.borderColor = UIColor.yellow.cgColor
        picker.layer.cornerRadius = Constants.cornerRadius
        return picker
    }()

    private let timeSubject = PassthroughSubject<Date, Never>()
    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.layer.borderWidth = Constants.borderWidth
        picker.layer.borderColor = UIColor.yellow.cgColor
        picker.layer.cornerRadius = Constants.cornerRadius
        return picker
    }()

    public var onDateChange: AnyPublisher<Date, Never> {
        Publishers.Merge(
            dateSubject.map { date in
                self.combineDateWithTime(date: date)
            },
            timeSubject.map { time in
                self.combineDateWithTime(time: time)
            }
        )
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

    @objc private func clickButton(_ sender: UIButton) {
        clickButton?()
    }

    @objc private func titleChanged(_ textField: UITextField) {
        titleSubject.send(textField.text ?? "")
    }

    @objc private func textChanged(_ textView: UITextView) {
        textSubject.send(textView.text ?? "")
    }

    @objc private func dateChanged(_ sender: UIDatePicker) {
        print(#function)
        dateSubject.send(sender.date)
    }

    @objc private func timeChanged(_ sender: UIDatePicker) {
        print(#function)
        timeSubject.send(sender.date)
    }

    private func combineDateWithTime(date: Date? = nil, time: Date? = nil) -> Date {
        print(#function)
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date ?? datePicker.date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time ?? timePicker.date)
        dateComponents.hour = timeComponents.hour
        dateComponents.minute = timeComponents.minute
        dateComponents.second = 0

        let dateTime = calendar.date(from: dateComponents) ?? date ?? time ?? Date()
        updateDateLabel(dateTime)
        return dateTime
    }

    private func updateDateLabel(_ date: Date) {
        dateLabel.text = date.toStringDateTime()
    }

    public func edit(item: ToDoItem) {
        titleField.text = item.title
        textView.text = item.text
        setDate(item.date)
    }

    private func setDate(_ date: Date) {
        datePicker.date = date
        timePicker.date = date
        updateDateLabel(date)
    }
}

extension CreateViewScreen {

    override func configureViews() {
        super.configureViews()

        addSubview(titleWindow)
        addSubview(titleField)
        addSubview(textView)
        addSubview(dateLabel)
        addSubview(datePicker)
        addSubview(timePicker)
        addSubview(createButton)

        setDate(Date())
        createButton.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        titleField.addTarget(self, action: #selector(titleChanged(_:)), for: .editingChanged)
        textView.delegate = self  // Устанавливаем делегат
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        timePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
    }

    override func configureConstraints() {
        super.configureConstraints()

        titleWindow.translatesAutoresizingMaskIntoConstraints = false
        titleField.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleWindow.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.medium),
            titleWindow.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.small),
            titleWindow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.small),

            titleField.topAnchor.constraint(equalTo: titleWindow.bottomAnchor, constant: Constants.large),
            titleField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.small),
            titleField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.small),

            textView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: Constants.medium),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.small),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.small),
            textView.heightAnchor.constraint(equalToConstant: Constants.heightContent),

            dateLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: Constants.medium),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.small),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.small),

            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Constants.medium),
            datePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.small),
            datePicker.trailingAnchor.constraint(equalTo: timePicker.leadingAnchor),
            datePicker.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),

            timePicker.topAnchor.constraint(equalTo: datePicker.topAnchor),
            timePicker.bottomAnchor.constraint(equalTo: datePicker.bottomAnchor),
            timePicker.leadingAnchor.constraint(equalTo: datePicker.trailingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.small),

            createButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: Constants.large),
            createButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.small),
            createButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.small),
        ])
    }

}

extension CreateViewScreen: UITextViewDelegate {
    // метод, вызываемый при изменении текста
    func textViewDidChange(_ textView: UITextView) {
        textSubject.send(textView.text)
    }
}
