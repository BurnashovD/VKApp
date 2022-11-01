// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Класс отвечает за отображение таблицы с группой пользователей
final class UserGroupsTableViewController: UITableViewController {
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

/// Constants
extension UserGroupsTableViewController {
    enum Constants {
        static let groupsCellIdentifier = "groups"
    }
}

// MARK: - UITableViewDataSource

extension UserGroupsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.groupsCellIdentifier, for: indexPath)

        return cell
    }
}
