// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Группы пользователей
final class UserGroupsTableViewController: UITableViewController {
    // MARK: - Private properties

    private var groups: [Group] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createGroups()
    }

    // MARK: - Private methods

    private func createGroups() {
        let firstGroup = Group(name: Constants.tsdGroupName, groupImageName: Constants.tsdImageName)
        let secondGroup = Group(name: Constants.omankoGroupName, groupImageName: Constants.omankoImageName)
        let thirdGroup = Group(name: Constants.redditGroupName, groupImageName: Constants.redditImageName)
        let fourGroup = Group(name: Constants.ffmGroupName, groupImageName: Constants.ffmImagename)
        let fiveGroup = Group(name: Constants.rusEconomicGroupName, groupImageName: Constants.economicImageName)
        let sixGroup = Group(name: Constants.adidasGroupName, groupImageName: Constants.adidasImageName)
        let sevenGroup = Group(name: Constants.mathGroupName, groupImageName: Constants.profileImageName)
        let eightGroup = Group(name: Constants.pizzaGroupName, groupImageName: Constants.pizzaImageName)
        let nineGroup = Group(name: Constants.mintGroupName, groupImageName: Constants.mintImagename)
        let tenGroup = Group(name: Constants.iosDevsGroupName, groupImageName: Constants.tsdImageName)

        groups.append(firstGroup)
        groups.append(secondGroup)
        groups.append(thirdGroup)
        groups.append(fourGroup)
        groups.append(fiveGroup)
        groups.append(sixGroup)
        groups.append(sevenGroup)
        groups.append(eightGroup)
        groups.append(nineGroup)
        groups.append(tenGroup)
    }
}

/// Constants
extension UserGroupsTableViewController {
    enum Constants {
        static let groupsCellIdentifier = "groups"
        static let tsdGroupName = "The Swift Developers"
        static let omankoGroupName = "OMANKO"
        static let redditGroupName = "Reddit"
        static let ffmGroupName = "Fast Food Music"
        static let rusEconomicGroupName = "Экономика РФ"
        static let adidasGroupName = "adidas Originals"
        static let mathGroupName = "Математика 5 класс"
        static let pizzaGroupName = "Pizza group"
        static let mintGroupName = "MINT"
        static let iosDevsGroupName = "IOS Devs"
        static let tsdImageName = "swift"
        static let omankoImageName = "omanko"
        static let redditImageName = "reddit"
        static let ffmImagename = "ffm"
        static let mintImagename = "mint"
        static let economicImageName = "rf"
        static let adidasImageName = "adidas"
        static let profileImageName = "profile"
        static let pizzaImageName = "pizza"
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension UserGroupsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.groupsCellIdentifier,
            for: indexPath
        ) as? GroupTableViewCell else { return UITableViewCell() }
        cell.refresh(groups[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
