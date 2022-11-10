// SortFriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Сортированный список друзей
final class SortFriendsTableViewController: UITableViewController {
    // MARK: - Private properties

    private var users: [User] = []
    private var sectionsDict = [Character: [String]]()
    private var imagesDict = [Character: [String]]()
    private var sectionTitles = [Character]()
    private var friendsPhotosNames: [String] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createUsers()
        createSections()
        configUI()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.sortAnimatedSegueIdentifier,
              let sortPhotos = segue.destination as? SortedFriendsPhotosViewController,
              let photos = sender as? [String] else { return }
        sortPhotos.getUserPhotos(photos: photos)
    }

    // MARK: - Private methods

    private func createUsers() {
        let firstUser = User(
            name: Constants.elonName,
            surname: Constants.elonSurname,
            profileImageName: [Constants.elonImageName, Constants.secondElonImageName, Constants.pizzaImageName]
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
            profileImageName: [Constants.pizzaImageName, Constants.dogImageName]
        )
        let sixUser = User(
            name: Constants.elonName,
            surname: Constants.elonSurname,
            profileImageName: [Constants.elonImageName, Constants.secondElonImageName]
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
        users.sort(by: { $0.name < $1.name })
    }

    private func configUI() {
        view.isUserInteractionEnabled = true
        friendsPhotosNames.append(Constants.elonImageName)
        friendsPhotosNames.append(Constants.dogImageName)
    }

    private func createSections() {
        for user in users {
            guard let firstLetter = user.surname.first, let image = user.profileImageName.first else { return }
            if sectionsDict[firstLetter] != nil {
                sectionsDict[firstLetter]?.append(user.surname)
                imagesDict[firstLetter]?.append(image)
            } else {
                sectionsDict[firstLetter] = [user.surname]
                imagesDict[firstLetter] = [image]
            }
        }
        sectionTitles = Array(sectionsDict.keys)
    }

    private func selectedRowAction() {
        let selectedRow = tableView.indexPathForSelectedRow
        guard let selectedRow = selectedRow,
              let currentCell = tableView.cellForRow(at: selectedRow) as? SortFriendTableViewCell,
              let image = currentCell.usersPhotoNames.first
        else { return }
        friendsPhotosNames.insert(image, at: 0)
        performSegue(withIdentifier: Constants.sortAnimatedSegueIdentifier, sender: friendsPhotosNames)
    }
}

/// Constants
extension SortFriendsTableViewController {
    enum Constants {
        static let friendsCellIdentifier = "sort"
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
        static let aleksandrSurname = "Aleksandr Nikolaevich"
        static let elonSurname = "Elon Musk"
        static let steveSurname = "Steve Jobs"
        static let danilSurname = "Danil Zebrov"
        static let pizzaImageName = "pizza"
        static let sortAnimatedSegueIdentifier = "sortAnimate"
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
            let user = sectionsDict[sectionTitles[indexPath.section]]?[indexPath.row],
            let image = imagesDict[sectionTitles[indexPath.section]]?[indexPath.row],
            let friendImage = UIImage(named: image)
        else { return UITableViewCell() }
        cell.configure(name: user, image: friendImage, [image])
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
