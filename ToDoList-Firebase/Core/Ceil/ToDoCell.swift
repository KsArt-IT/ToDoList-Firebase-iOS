//
//  ToDoCell.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 16.09.2024.
//

import UIKit

final class ToDoCell: UITableViewCell {

    static let indentifier = "ToDoCell"

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 17, weight: .bold, width: .standard)
        label.numberOfLines = 1
        label.text = "title"
        return label
    }()
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 17, weight: .regular, width: .standard)
        label.adjustsFontSizeToFitWidth = true // Включаем авто изменение размера шрифта
        label.minimumScaleFactor = 9 / 17 // Устанавливаем минимальный коэффициент изменения размера шрифта
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.text = "text"
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light, width: .condensed)
        label.textColor = .blue
        label.text = R.Strings.dateTimeFormat
        return label
    }()
    private let completeImageView: UIImageView = {
        let view = UIImageView()

        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(item: ToDoItem) {
        titleLabel.text = item.title
        noteLabel.text = item.text

        dateLabel.text = item.date.toStringDateTime()
        // установим цвет даты в зависимости от просроченности выполнения
        if item.isCompleted || Date() < item.date {
            dateLabel.textColor = .blue
            contentView.layer.borderColor = UIColor.blue.cgColor
        } else {
            dateLabel.textColor = .red
            contentView.layer.borderColor = UIColor.red.cgColor
        }
        completeImageView.image = item.isCompleted ? UIImage(systemName: "checkmark.seal") : UIImage(systemName: "seal")
    }
}

extension ToDoCell {
    private func configureViews() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(noteLabel)
        stackView.addArrangedSubview(dateLabel)

        contentView.addSubview(stackView)
        contentView.addSubview(completeImageView)

        contentView.layer.borderWidth = Constants.borderWidth
        contentView.layer.borderColor = UIColor.blue.cgColor
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.backgroundColor = .clear
    }

    private func configureConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        completeImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.tiny),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.small),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.tiny),
            stackView.trailingAnchor.constraint(equalTo: completeImageView.leadingAnchor, constant: -Constants.small),

            completeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            completeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.small),
            completeImageView.heightAnchor.constraint(equalToConstant: Constants.sizeIcon),
            completeImageView.widthAnchor.constraint(equalToConstant: Constants.sizeIcon),
        ])
    }

}
