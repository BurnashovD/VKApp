// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Класс отвечает за таблицу с друзьями пользователя
final class FriendsTableViewController: UITableViewController {
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

/// Constants
extension FriendsTableViewController {
    enum Constants {
        static let friendsCellIdentifier = "friends"
        static let phototSegueIdentifier = "photosSegue"
    }
}

// MARK: - UITableViewControllerDelegate, UITableViewControllerDataSource

extension FriendsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.friendsCellIdentifier, for: indexPath)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.phototSegueIdentifier, sender: self)
    }
}
