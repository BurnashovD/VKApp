// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с друзьями пользователя
final class FriendsTableViewController: UITableViewController {
    private let cellTypes: [CellTypes] = [.friends, .recomendations, .nextFriends]

    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        createUsers()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.phototSegueIdentifier,
              let photoCollection = segue.destination as? PhotosCollectionViewController,
              let image = sender as? UIImage else { return }
        photoCollection.image = image
    }

    private func createUsers() {
        let firstUser = User(name: Constants.elonName, profileImageName: Constants.elonImageName)
        let secondUser = User(name: Constants.elonName, profileImageName: Constants.secondElonImageName)
        let thirdUser = User(name: Constants.steveName, profileImageName: Constants.steveImageName)
        let fourUser = User(name: Constants.elonName, profileImageName: Constants.elonImageName)
        let fiveUser = User(name: Constants.daniilName, profileImageName: Constants.dogImageName)
        let sixUser = User(name: Constants.elonName, profileImageName: Constants.elonImageName)
        let sevenUser = User(name: Constants.steveName, profileImageName: Constants.steveImageName)
        let eightUser = User(name: Constants.daniilName, profileImageName: Constants.secondElonImageName)
        let nineUser = User(name: Constants.aleksandrName, profileImageName: Constants.dogImageName)
        let tenUser = User(name: Constants.steveName, profileImageName: Constants.steveImageName)

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
        static let aleksandrName = "Aleksandr Aleksandrovich"
        static let daniilName = "Daniil Daniilov"
        static let elonName = "Elon Musk"
        static let steveName = "Steve Jobs"
    }

    enum CellTypes {
        case friends
        case recomendations
        case nextFriends
    }
}

// MARK: - UITableViewControllerDelegate, UITableViewControllerDataSource

extension FriendsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = cellTypes[section]
        switch type {
        case .friends:
            return users.count
        case .recomendations:
            return 1
        case .nextFriends:
            return users.count
        }
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
            cell.refresh(users[Int.random(in: 0 ... (users.count - 1))])

            return cell

        case .nextFriends:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.friendsCellIdentifier,
                for: indexPath
            ) as? FriendTableViewCell else { return UITableViewCell() }
            cell.refresh(users[indexPath.row])

            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = tableView.indexPathForSelectedRow
        guard let selectedRow = selectedRow,
              let user = tableView.cellForRow(at: selectedRow) as? FriendTableViewCell else { return }
        let photosCVC = PhotosCollectionViewController()
        photosCVC.refresh(tableViewController: user)
        performSegue(withIdentifier: Constants.phototSegueIdentifier, sender: user.profileImageView.image)
    }
}
