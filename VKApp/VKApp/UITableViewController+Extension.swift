// UITableViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UITableViewController {
    func addNewGroupAlertAction(
        controllerTitle: String,
        actionTitle: String,
        groupImageName: String,
        controller: UITableViewController
    ) {
        let alertController = UIAlertController(
            title: controllerTitle,
            message: nil,
            preferredStyle: .alert
        )
        alertController.addTextField()
        let alertAction = UIAlertAction(title: actionTitle, style: .cancel) { _ in
            guard let text = alertController.textFields?[0], let groupName = text.text,
                  let controller = controller as? GlobalSearchTableViewController else { return }
            controller.globalGroups.insert(Group(name: groupName, groupImageName: groupImageName), at: 0)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}
