// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с друзьями пользователя
final class FriendsTableViewController: UITableViewController {
    // MARK: - Private properties

    private let cellTypes: [CellTypes] = [.friends, .recomendations, .nextFriends]

    // MARK: - Public properties

    var users: [User] = []
    var sections = [Character: [String]]()
    var sectionTitles = [Character]()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createUsers()
        createSections()
    }

    // MARK: - Public methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.phototSegueIdentifier,
              let photoCollection = segue.destination as? PhotosCollectionViewController,
              let image = sender as? UIImage else { return }
        photoCollection.image = image
    }

    // MARK: - Private methods

    private func createUsers() {
        let firstUser = User(
            name: Constants.elonName,
            surname: Constants.elonSurname,
            profileImageName: Constants.elonImageName
        )
        let secondUser = User(
            name: Constants.elonName,
            surname: Constants.elonSurname,
            profileImageName: Constants.secondElonImageName
        )
        let thirdUser = User(
            name: Constants.steveName,
            surname: Constants.steveSurname,
            profileImageName: Constants.steveImageName
        )
        let fourUser = User(
            name: Constants.elonName,
            surname: Constants.elonSurname,
            profileImageName: Constants.elonImageName
        )
        let fiveUser = User(
            name: Constants.daniilName,
            surname: Constants.danilSurname,
            profileImageName: Constants.pizzaImageName
        )
        let sixUser = User(
            name: Constants.elonName,
            surname: Constants.elonSurname,
            profileImageName: Constants.elonImageName
        )
        let sevenUser = User(
            name: Constants.steveName,
            surname: Constants.steveSurname,
            profileImageName: Constants.steveImageName
        )
        let eightUser = User(
            name: Constants.daniilName,
            surname: Constants.danilSurname,
            profileImageName: Constants.pizzaImageName
        )
        let nineUser = User(
            name: Constants.aleksandrName,
            surname: Constants.aleksandrSurname,
            profileImageName: Constants.dogImageName
        )
        let tenUser = User(
            name: Constants.steveName,
            surname: Constants.steveSurname,
            profileImageName: Constants.steveImageName
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

    private func createSections() {
        for user in users {
            guard let firstLetter = user.surname.first else { return }
            sections[firstLetter] = [user.surname]
            sectionTitles = Array(sections.keys)
            print("section \(sections)")
            print("title \(sectionTitles)")
        }
        sectionTitles.sort(by: { $0 > $1 })

//        sectionTitles = Array(sections.keys)
    }

    private func selectedRowAction() {
        let selectedRow = tableView.indexPathForSelectedRow
        guard let selectedRow = selectedRow,
              let user = tableView.cellForRow(at: selectedRow) as? FriendTableViewCell,
              let image = user.profileImageView.image else { return }
        performSegue(withIdentifier: Constants.phototSegueIdentifier, sender: image)
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
        static let aleksandrName = "Aleksandr"
        static let daniilName = "Daniil"
        static let elonName = "Elon"
        static let steveName = "Steve"
        static let aleksandrSurname = "Nikolaevich"
        static let elonSurname = "Musk"
        static let steveSurname = "Jobs"
        static let danilSurname = "Zebrov"
        static let pizzaImageName = "pizza"
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


//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        40
//    }

//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        sectionTitles.map { String($0) }
//    }
//
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        String(sectionTitles[section])
//    }
}
