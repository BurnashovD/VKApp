// UIViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// UIViewController extension
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

    func fetchUsersPhotos(_ url: String, _ complition: @escaping (UIImage) -> Void) {
        let networkService = NetworkService()
        networkService.fetchUserPhotos(url) { item in
            complition(item)
        }
    }
}
