// SortFriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

///  Сортированный список друзей
final class SortFriendsTableViewController: UITableViewController {
    // MARK: - Private properties

    private let vkApiService = VKAPIService()

    private var friends: [Item] = []
    private var sectionsDict = [Character: [String]]()
    private var namesDict = [Character: [String]]()
    private var imagesDict = [Character: [String]]()
    private var sectionTitles = [Character]()
    private var decodePhotos = [Character: [UIImage]]()
    private var userPhotos: [UIImage] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFriends()
        configUI()
    }

    // MARK: - Public methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.sortAnimatedSegueIdentifier,
              let sortPhotos = segue.destination as? SortedFriendsPhotosViewController,
              let photos = sender as? [UIImage] else { return }
        sortPhotos.usersPhotosNames = photos
    }

    // MARK: - Private methods

    private func configUI() {
        tableView.isUserInteractionEnabled = true
    }

    private func createSections() {
        for user in friends {
            guard let firstLetter = user.lastName.first else { return }
            if sectionsDict[firstLetter] != nil {
                sectionsDict[firstLetter]?.append(user.lastName)
                namesDict[firstLetter]?.append(user.firstName)
                imagesDict[firstLetter]?.append(user.photo)
            } else {
                sectionsDict[firstLetter] = [user.lastName]
                namesDict[firstLetter] = [user.firstName]
                imagesDict[firstLetter] = [user.photo]
            }
        }
    }

    private func selectedRowAction() {
        let selectedRow = tableView.indexPathForSelectedRow
        guard let selectedRow = selectedRow,
              let currentCell = tableView.cellForRow(at: selectedRow) as? SortFriendTableViewCell
        else { return }
        performSegue(withIdentifier: Constants.sortAnimatedSegueIdentifier, sender: userPhotos)
    }

    private func fetchFriends() {
        vkApiService.fetchUsers(
            Constants.friendsMethodName,
            parametrMap: [
                Constants.fieldsParametrName: Constants.getPhotoParametrName,
                Constants.orderParametrName: Constants.nameParametrName
            ]
        ) { [weak self] item in
            self?.friends = item
            self?.createSections()
            self?.fetchPhoto()
            guard let keys = self?.sectionsDict.keys else { return }
            self?.sectionTitles = Array(keys)
            self?.sectionTitles.sort(by: { $1 > $0 })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self?.tableView.reloadData()
            }
        }
    }

    private func fetchPhoto() {
        for photo in imagesDict {
            let imagesArray = photo.value
            var images = [UIImage]()
            for url in imagesArray {
                AF.request(url).response { response in
                    guard let result = response.data, let userPhoto = UIImage(data: result) else { return }
                    images.append(userPhoto)
                    self.decodePhotos[photo.key] = images
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
        sectionsDict.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionNumbers = sectionsDict[sectionTitles[section]]?.count else { return Int() }
        return sectionNumbers
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.friendsCellIdentifier,
            for: indexPath
        ) as? SortFriendTableViewCell,
            let name = sectionsDict[sectionTitles[indexPath.section]]?[indexPath.row],
            let surname = namesDict[sectionTitles[indexPath.section]]?[indexPath.row],
            let image = decodePhotos[sectionTitles[indexPath.section]]?[indexPath.row]
        else { return UITableViewCell() }
        cell.configure(name: name, surname: surname, photo: image)
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
