// GlobalSearchTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Глобальный поиск
final class GlobalSearchTableViewController: UITableViewController {
    // MARK: - Private properties

    private var globalGroups: [Group] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createGroups()
    }

    // MARK: - Private methods

    private func createGroups() {} // добавить группы и готово
}

/// Constants
extension GlobalSearchTableViewController {
    enum Constants {
        static let globalGroupsCellIdentifier = "globalGroup"
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension GlobalSearchTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        globalGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.globalGroupsCellIdentifier,
            for: indexPath
        ) as? GlobalGroupsTableViewCell else { return UITableViewCell() }
        cell.refresh(globalGroups[indexPath.row])

        return cell
    }
}
