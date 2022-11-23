// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с друзьями пользователя
final class FriendsTableViewController: UITableViewController {
    // MARK: - Private properties

    private let cellTypes: [CellTypes] = [.friends, .recomendations, .nextFriends]
    private let vkApiService = VKAPIService()

    private var users: [User] = []
    private var usersImagesNames: [String] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createUsers()
        fetchFriends()
        fetchUsersPhotos()
    }

    // MARK: - Public methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.phototSegueIdentifier,
              let photoCollection = segue.destination as? PhotosCollectionViewController,
              let image = sender as? UIImage
        else { return }
        photoCollection.getUserPhotoNames(usersImagesNames, profilePhoto: image)
    }

    // MARK: - Private methods

    private func createUsers() {
        let firstUser = User(
            name: Constants.elonName,
            surname: Constants.elonSurname,
            profileImageName: [Constants.elonImageName, Constants.secondElonImageName]
        )
        let secondUser = User(
            name: Constants.elonName,
            surname: Constants.elonSurname,
            profileImageName: [Constants.secondElonImageName, Constants.elonImageName, Constants.pizzaImageName]
        )
        let thirdUser = User(
            name: Constants.steveName,
            surname: Constants.steveSurname,
            profileImageName: [Constants.steveImageName, Constants.pizzaImageName, Constants.dogImageName]
        )
        let fourUser = User(
            name: Constants.elonName,
            surname: Constants.elonSurname,
            profileImageName: [Constants.elonImageName, Constants.secondElonImageName, Constants.dogImageName]
        )
        let fiveUser = User(
            name: Constants.daniilName,
            surname: Constants.danilSurname,
            profileImageName: [Constants.pizzaImageName, Constants.dogImageName, Constants.secondElonImageName]
        )
        let sixUser = User(
            name: Constants.elonName,
            surname: Constants.elonSurname,
            profileImageName: [Constants.elonImageName, Constants.secondElonImageName, Constants.pizzaImageName]
        )
        let sevenUser = User(
            name: Constants.steveName,
            surname: Constants.steveSurname,
            profileImageName: [Constants.steveImageName, Constants.pizzaImageName, Constants.dogImageName]
        )
        let eightUser = User(
            name: Constants.daniilName,
            surname: Constants.danilSurname,
            profileImageName: [Constants.pizzaImageName, Constants.dogImageName, Constants.dogImageName]
        )
        let nineUser = User(
            name: Constants.aleksandrName,
            surname: Constants.aleksandrSurname,
            profileImageName: [Constants.dogImageName, Constants.pizzaImageName, Constants.pizzaImageName]
        )
        let tenUser = User(
            name: Constants.steveName,
            surname: Constants.steveSurname,
            profileImageName: [Constants.steveImageName, Constants.pizzaImageName, Constants.dogImageName]
        )

        for _ in 0 ... 1 {
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

    private func selectedRowAction() {
        let selectedRow = tableView.indexPathForSelectedRow
        guard let selectedRow = selectedRow,
              let user = tableView.cellForRow(at: selectedRow) as? FriendTableViewCell,
              let image = user.profileImageView.image else { return }
        usersImagesNames = user.usersImagesNames
        performSegue(withIdentifier: Constants.phototSegueIdentifier, sender: image)
    }

    private func fetchFriends() {
        vkApiService.fetchData(
            Constants.friendsMethodName,
            parametrMap: [
                Constants.fieldsParametrName: Constants.idParametrName,
                Constants.orderParametrName: Constants.nameParametrName
            ]
        )
    }

    private func fetchUsersPhotos() {
        vkApiService.fetchData(
            Constants.photosMethodName,
            parametrMap: [
                Constants.ownerIdParametrName: String(Session.shared.userId),
                Constants.albumIdParametrName: Constants.profileParametrName
            ]
        )
    }
}

/// Constants
extension FriendsTableViewController {
    private enum Constants {
        static let friendsCellIdentifier = "friends"
        static let phototSegueIdentifier = "photosSegue"
        static let elonImageName = "em3"
        static let secondElonImageName = "secondElon"
        static let steveImageName = "steve"
        static let dogImageName = "dogg"
        static let recomendationsCellIdentifier = "recomendations"
        static let aleksandrName = "Aleksandr"
        static let daniilName = "Daniil"
        static let elonName = "Elon"
        static let steveName = "Steve"
        static let aleksandrSurname = "Nikolaevich"
        static let elonSurname = "Musk"
        static let steveSurname = "Jobs"
        static let danilSurname = "Zebrov"
        static let pizzaImageName = "pizza"
        static let friendsMethodName = "friends.get"
        static let fieldsParametrName = "fields"
        static let idParametrName = "id"
        static let orderParametrName = "order"
        static let nameParametrName = "name"
        static let photosMethodName = "photos.get"
        static let ownerIdParametrName = "owner_id"
        static let albumIdParametrName = "album_id"
        static let profileParametrName = "profile"
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
        cellTypes.count
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

            cell.configure(users[indexPath.row])

            return cell

        case .recomendations:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.recomendationsCellIdentifier,
                for: indexPath
            ) as? RecomendationsTableViewCell else { return UITableViewCell() }

            cell.configure(users[Int.random(in: 0 ... (users.count - 1))])

            return cell
        case .nextFriends:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.friendsCellIdentifier,
                for: indexPath
            ) as? FriendTableViewCell else { return UITableViewCell() }

            cell.configure(users[indexPath.row])

            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowAction()
    }
}
