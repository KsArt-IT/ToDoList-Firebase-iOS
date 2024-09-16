//
//  TextPicker.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 13.09.2024.
//

import UIKit

final class TextPicker {

    typealias todoNote = (title: String, text: String)

    func show(in viewController: UIViewController, title: String = "", text: String = "", dismiss: @escaping () -> Void = {}, complition: @escaping (todoNote) -> Void) {

        let allertController = UIAlertController(title: R.Strings.titleToDo, message: nil, preferredStyle: .alert)
        // title
        allertController.addTextField { textField in
            textField.placeholder = R.Strings.placeholderTitle
            if !title.isEmpty {
                textField.text = title
            }
        }

        allertController.addTextField { textField in
            textField.placeholder = R.Strings.placeholderNote
            if !text.isEmpty {
                textField.text = text
            }
        }

        let okAction = UIAlertAction(title: R.Strings.okAction, style: .default){ _ in
            complition((title: allertController.textFields?[0].text ?? "", text: allertController.textFields?[1].text ?? ""))
            dismiss()
        }
        let cancelAction = UIAlertAction(title: R.Strings.cancelAction, style: .cancel) { _ in
            dismiss()
        }

        allertController.addAction(okAction)
        allertController.addAction(cancelAction)

        viewController.present(allertController, animated: true)
    }
}
