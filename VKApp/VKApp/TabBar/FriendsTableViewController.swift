// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с друзьями пользователя
final class FriendsTableViewController: UITableViewController {
    private let cellTypes: [CellTypes] = [.friends, .recomendations, .friends]

    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        createUsers()
    }

    private func createUsers() {
        let firstUser = User(name: "Mark", profileImageName: Constants.elonImageName)
        let secondUser = User(name: "Mark", profileImageName: Constants.secondElonImageName)
        let thirdUser = User(name: "Mark", profileImageName: Constants.steveImageName)
        let fourUser = User(name: "Mark", profileImageName: Constants.elonImageName)
        let fiveUser = User(name: "Mark", profileImageName: Constants.dogImageName)
        let sixUser = User(name: "Mark", profileImageName: Constants.elonImageName)
        let sevenUser = User(name: "Mark", profileImageName: Constants.steveImageName)
        let eightUser = User(name: "Mark", profileImageName: Constants.secondElonImageName)
        let nineUser = User(name: "Mark", profileImageName: Constants.dogImageName)
        let tenUser = User(name: "Mark", profileImageName: Constants.steveImageName)

        users.append(firstUser)
        users.append(secondUser)
        users.append(thirdUser)
        users.append(fourUser)
        users.append(fiveUser)
        users.append(sixUser)
        users.append(sevenUser)
        users.append(eightUser)
        users.append(nineUser)
        users.append(tenUser)
    }
}

/// Constants
extension FriendsTableViewController {
    enum Constants {
        static let friendsCellIdentifier = "friends"
        static let phototSegueIdentifier = "photosSegue"
        static let elonImageName = "em3"
        static let secondElonImageName = "secondElon"
        static let steveImageName = "steve"
        static let dogImageName = "dogg"
        static let recomendationsCellIdentifier = "recomendations"
    }

    enum CellTypes {
        case friends
        case recomendations
    }
}

// MARK: - UITableViewControllerDelegate, UITableViewControllerDataSource

extension FriendsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = cellTypes[indexPath.section]
        switch type {
        case .friends:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.friendsCellIdentifier,
                for: indexPath
            ) as? FriendTableViewCell else { return UITableViewCell() }
            cell.refresh(users[indexPath.row])

            return cell
        case .recomendations:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.recomendationsCellIdentifier,
                for: indexPath
            ) as? RecomendationsTableViewCell else { return UITableViewCell() }

            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.phototSegueIdentifier, sender: self)
    }
}
