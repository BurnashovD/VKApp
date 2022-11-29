// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран с друзьями пользователя
final class FriendsTableViewController: UITableViewController {
    // MARK: - Private properties

    private let cellTypes: [CellTypes] = [.friends, .recomendations]
    private let networkService = NetworkService()
    private let realmService = RealmService()

    private var items: [Item] = []
    private var itemsResult: Results<Item>?
    private var userId = 0

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFriends()
    }

    // MARK: - Public methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.phototSegueIdentifier,
              let photoCollection = segue.destination as? PhotosCollectionViewController,
              let id = sender as? Int
        else { return }
        photoCollection.getUserId(id: id)
    }

    // MARK: - Private methods

    private func selectedRowAction() {
        let selectedRow = tableView.indexPathForSelectedRow
        guard let selectedRow = selectedRow,
              let user = tableView.cellForRow(at: selectedRow) as? FriendTableViewCell else { return }
        userId = user.userId
        performSegue(withIdentifier: Constants.phototSegueIdentifier, sender: userId)
    }

    private func fetchFriends() {
        networkService.fetchUsers(
            Constants.friendsMethodName,
            parametrMap: networkService.fetchFriendsParametrName
        ) { [weak self] _ in
            guard let self = self else { return }
            self.getFriendsData()
        }
    }

    private func getFriendsData() {
        realmService.getData(Item.self) { [weak self] item in
            guard let self = self else { return }
            self.items = item
            self.tableView.reloadData()
        }
    }
}

/// Constants
extension FriendsTableViewController {
    private enum Constants {
        static let friendsCellIdentifier = "friends"
        static let phototSegueIdentifier = "photosSegue"
        static let recomendationsCellIdentifier = "recomendations"
        static let friendsMethodName = "friends.get"
        static let fieldsParametrName = "fields"
        static let idParametrName = "id"
        static let orderParametrName = "order"
        static let nameParametrName = "name"
        static let photosMethodName = "photos.get"
        static let ownerIdParametrName = "owner_id"
        static let albumIdParametrName = "album_id"
        static let profileParametrName = "profile"
        static let getPhotoParametrName = "photo_100"
    }

    enum CellTypes {
        case friends
        case recomendations
    }
}

// MARK: - UITableViewControllerDelegate, UITableViewControllerDataSource

extension FriendsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = cellTypes[section]
        switch type {
        case .friends:
            return items.count
        case .recomendations:
            return 1
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

            cell.configure(items[indexPath.row], networkService: networkService)

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
        selectedRowAction()
    }
}
