// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Группы пользователей
final class UserGroupsTableViewController: UITableViewController {}

/// Constants
extension UserGroupsTableViewController {
    enum Constants {
        static let groupsCellIdentifier = "groups"
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

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
