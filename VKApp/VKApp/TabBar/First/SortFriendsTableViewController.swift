// SortFriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import PromiseKit
import RealmSwift
import UIKit

///  Сортированный список друзей
final class SortFriendsTableViewController: UITableViewController {
    // MARK: - Private properties

    private let networkService = NetworkService()
    private let realmService = RealmService()

    private var items: [UserItem] = []
    private var notificationToken: NotificationToken?
    private var itemsResult: Results<UserItem>?
    private var sectionsMap = [Character: [String]]()
    private var namesMap = [Character: [String]]()
    private var imagesMap = [Character: [String]]()
    private var sectionTitles = [Character]()
    private var decodePhotosMap = [Character: [UIImage]]()
    private var userPhotoImages: [UIImage] = []
    private var userId = 0

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFriend()
        configUI()
        addNotificationToken()
    }

    // MARK: - Private methods

    private func configUI() {
        tableView.isUserInteractionEnabled = true
    }

    private func createSections() {
        for user in items {
            guard let firstLetter = user.lastName.first else { return }
            if sectionsMap[firstLetter] != nil {
                sectionsMap[firstLetter]?.append(user.lastName)
                namesMap[firstLetter]?.append(user.firstName)
                imagesMap[firstLetter]?.append(user.photo)
            } else {
                sectionsMap[firstLetter] = [user.lastName]
                namesMap[firstLetter] = [user.firstName]
                imagesMap[firstLetter] = [user.photo]
            }
        }
    }

    private func selectedRowAction() {
        let selectedRow = tableView.indexPathForSelectedRow
        guard let selectedRow = selectedRow,
              let user = tableView.cellForRow(at: selectedRow) as? SortFriendTableViewCell else { return }
        Session.shared.userId = user.userId
        performSegue(withIdentifier: Constants.sortAnimatedSegueIdentifier, sender: userPhotoImages)
    }

    private func fetchFriend() {
        firstly {
            networkService.fetchUsersPromise(Constants.friendsMethodName)
        }.done { user in
            self.realmService.saveData(user)
        }.catch { error in
            print(error.localizedDescription)
        }.finally {
            self.realmService.loadData(UserItem.self) { [weak self] friend in
                guard let self = self else { return }
                self.itemsResult = friend
                self.items = Array(self.itemsResult ?? friend)
                self.createSections()
                self.sectionTitles = Array(self.sectionsMap.keys)
                self.sectionTitles.sort(by: { $1 > $0 })
                self.fetchPhoto()
            }
        }
    }

    private func addNotificationToken() {
        notificationToken = itemsResult?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .initial:
                self.tableView.reloadData()
            case let .update(_, deletions, insertions, modifications):
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.endUpdates()
            case let .error(error):
                print(error)
            }
        }
    }

    private func fetchPhoto() {
        for photo in imagesMap {
            let imagesArray = photo.value
            var images = [UIImage]()
            for url in imagesArray {
                networkService.fetchUserPhotos(url) { [weak self] data in
                    guard let self = self, let data = data, let safeImage = UIImage(data: data) else { return }
                    images.append(safeImage)
                    self.decodePhotosMap[photo.key] = images
                    if self.decodePhotosMap.count == self.imagesMap.count {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}

/// Constants
extension SortFriendsTableViewController {
    private enum Constants {
        static let friendsCellIdentifier = "sort"
        static let phototSegueIdentifier = "photosSegue"
        static let sortAnimatedSegueIdentifier = "sortAnimate"
        static let friendsMethodName = "friends.get"
        static let fieldsParametrName = "fields"
        static let idParametrName = "id"
        static let orderParametrName = "order"
        static let nameParametrName = "name"
        static let getPhotoParametrName = "photo_100"
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SortFriendsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionsMap.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionNumbers = sectionsMap[sectionTitles[section]]?.count else { return Int() }
        return sectionNumbers
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.friendsCellIdentifier,
            for: indexPath
        ) as? SortFriendTableViewCell,
            let name = sectionsMap[sectionTitles[indexPath.section]]?[indexPath.row],
            let surname = namesMap[sectionTitles[indexPath.section]]?[indexPath.row],
            let image = decodePhotosMap[sectionTitles[indexPath.section]]?[indexPath.row]
        else { return UITableViewCell() }
        cell.configure(name: name, surname: surname, photo: image, item: items[indexPath.item])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowAction()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.contentView.backgroundColor = .none
        headerView.textLabel?.textColor = .white
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitles.map { String($0) }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sectionTitles[section])
    }
}
