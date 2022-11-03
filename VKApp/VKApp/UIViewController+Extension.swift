// UIViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// CallAlert extension
extension UIViewController {
    func callAlertAction(controllerTitle: String, actionTitle: String, textField: Bool) {
        let alertController = UIAlertController(
            title: controllerTitle,
            message: nil,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: actionTitle, style: .cancel)
        alertController.addAction(alertAction)
        if textField == true {
            alertController.addTextField()
        }
        present(alertController, animated: true)
    }
}
