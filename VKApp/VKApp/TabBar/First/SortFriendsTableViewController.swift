// SortFriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

///  Сортированный список друзей
final class SortFriendsTableViewController: UITableViewController {
    // MARK: - Private properties

    private let networkService = NetworkService()

    private var items: [Item] = []
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
        fetchFriends()
        configUI()
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

    private func fetchFriends() {
        networkService.fetchUsers(
            Constants.friendsMethodName,
            parametrMap: networkService.fetchFriendsParametrName
        ) { [weak self] item in
            guard let self = self else { return }
            self.items = item
            self.createSections()
            self.sectionTitles = Array(self.sectionsMap.keys)
            self.sectionTitles.sort(by: { $1 > $0 })
            self.fetchPhoto()
        }
    }

    private func fetchPhoto() {
        for photo in imagesMap {
            let imagesArray = photo.value
            var images = [UIImage]()
            for url in imagesArray {
                networkService.fetchSortedUsersPhotos(url) { [weak self] items in
                    images.append(items)
                    self?.decodePhotosMap[photo.key] = images
                    if self?.decodePhotosMap.count == self?.imagesMap.count {
                        self?.tableView.reloadData()
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
