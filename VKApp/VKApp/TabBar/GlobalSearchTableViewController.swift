// GlobalSearchTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Глобальный поиск
final class GlobalSearchTableViewController: UITableViewController {}

/// Constants
extension GlobalSearchTableViewController {
    enum Constants {
        static let globalGroupsCellIdentifier = "globalGroups"
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension GlobalSearchTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.globalGroupsCellIdentifier, for: indexPath)

        return cell
    }
}
