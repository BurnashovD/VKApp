// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import PromiseKit
import RealmSwift
import UIKit

/// Экран с друзьями пользователя
final class FriendsTableViewController: UITableViewController {
    // MARK: - Private properties

    private let cellTypes: [CellTypes] = [.friends, .recomendations]
    private let networkService = NetworkService()
    private let realmService = RealmService()

    private var notificationToken: NotificationToken?
    private var userItems: [UserItem] = []
    private var itemsResult: Results<UserItem>?
    private var userId = 0
    private var postItems: [PostItem] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFriend()
        addNotificationToken()
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

    private func fetchFriend() {
        firstly {
            networkService.fetchUsersPromise(Constants.friendsMethodName)
        }.done { _ in
            self.realmService.loadData(UserItem.self) { [weak self] item in
                guard let self = self else { return }
                self.itemsResult = item
                self.userItems = Array(item)
                self.tableView.reloadData()
            }
        }
    }

    private func loadData() {
        realmService.loadData(UserItem.self) { [weak self] item in
            guard let self = self else { return }
            self.itemsResult = item
            self.userItems = Array(item)
            self.tableView.reloadData()
        }
    }

    private func addNotificationToken() {
        loadData()
        guard let result = itemsResult else { return }
        notificationToken = result.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            self.tableView.beginUpdates()
            switch changes {
            case .initial:
                self.tableView.beginUpdates()
            case let .update(_, deletions, insertions, modifications):
                self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.endUpdates()
            case let .error(error):
                print(error.localizedDescription)
            }
            self.tableView.endUpdates()
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
        static let newsGetMethodName = "newsfeed.get"
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
        guard let resultsCount = itemsResult?.count else { return 0 }
        switch type {
        case .friends:
            return resultsCount
        case .recomendations:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = cellTypes[indexPath.section]
        switch type {
        case .friends:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.friendsCellIdentifier,
                for: indexPath
            ) as? FriendTableViewCell, let results = itemsResult else { return UITableViewCell() }
            cell.configure(results[indexPath.row], networkService: networkService)

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
