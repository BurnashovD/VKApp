// GlobalSearchTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Глобальный поиск
final class GlobalSearchTableViewController: UITableViewController {
    // MARK: - Public properties

    var globalGroups: [Group] = []
    
    // MARK: - Private properties
    
    private let vkAPI = VKAPIService()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createGroups()
        getGlobalGroups()
    }

    // MARK: - IBActions

    @IBAction private func addNewGroupAction(_ sender: Any) {
        addNewGroupAlertAction(
            controllerTitle: Constants.chooseGroupNameText,
            actionTitle: Constants.okText,
            groupImageName: Constants.profileImageName,
            controller: self
        )
    }

    @IBAction private func backToGroupsAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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

        globalGroups.append(firstGroup)
        globalGroups.append(secondGroup)
        globalGroups.append(thirdGroup)
        globalGroups.append(fourGroup)
        globalGroups.append(fiveGroup)
        globalGroups.append(sixGroup)
        globalGroups.append(sevenGroup)
        globalGroups.append(eightGroup)
        globalGroups.append(nineGroup)
        globalGroups.append(tenGroup)
    }
    
    private func getGlobalGroups() {
        vkAPI.getData(Constants.methodName,
                      parametrName: Constants.qParametrName,
                      parametr: Constants.searchedText,
                      secondParametrName: Constants.typeparametrName,
                      secondParametr: Constants.groupTypeName)
    }
}

/// Constants
extension GlobalSearchTableViewController {
    private enum Constants {
        static let globalGroupsCellIdentifier = "globalGroup"
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
        static let chooseGroupNameText = "Введите название группы"
        static let okText = "Ок"
        static let methodName = "groups.search"
        static let qParametrName = "q"
        static let searchedText = "Swift"
        static let typeparametrName = "type"
        static let groupTypeName = "group"
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension GlobalSearchTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        globalGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.globalGroupsCellIdentifier,
            for: indexPath
        ) as? GlobalGroupsTableViewCell else { return UITableViewCell() }
        cell.configure(globalGroups[indexPath.row])

        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        globalGroups.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
