// SortFriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SortFriendsTableViewController: UITableViewController {
    // MARK: - Private properties

    private var users: [User] = []
    private var sections = [Character: [String]]()
    private var sectionTitles = [Character]()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createUsers()
//        createSections()
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
    }
}

/// Constants
extension SortFriendsTableViewController {
    enum Constants {
        static let friendsCellIdentifier = "friend"
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
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SortFriendsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.friendsCellIdentifier,
            for: indexPath
        ) as? FriendTableViewCell else { return UITableViewCell() }
        cell.configure(users[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        40
//    }
//
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        sectionTitles.map { String($0) }
//    }
//
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        String(sectionTitles[section])
//    }
}
