// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Группы пользователей
final class UserGroupsTableViewController: UITableViewController {
    // MARK: - Visual components

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: Constants.searchBarPlaceholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        return searchBar
    }()

    // MARK: - Private properties

    private let networkService = NetworkService()
    private let realmService = RealmService()

    private var searchResult: [Groups] = []
    private var groups: [Groups] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configController()
        fetchUsersGroups()
    }

    // MARK: - Private methods

    private func configController() {
        searchBar.delegate = self
    }

    private func fetchUsersGroups() {
        networkService.fetchGroup(
            Constants.methodName,
            parametrMap: networkService.userGroupParametrsNames
        ) { [weak self] _ in
            guard let self = self else { return }
            self.getGroupsData()
        }
    }

    private func getGroupsData() {
        realmService.getData(Groups.self) { [weak self] group in
            guard let self = self else { return }
            self.groups = group
            self.searchResult = self.groups
            self.tableView.reloadData()
        }
    }
}

/// Constants
extension UserGroupsTableViewController {
    private enum Constants {
        static let groupsCellIdentifier = "groups"
        static let searchBarPlaceholderText = " Поиск..."
        static let methodName = "groups.get"
        static let userIdParametrName = "user_id"
        static let extendedParametrName = "extended"
        static let extendedParametrValue = "1"
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension UserGroupsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResult.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.groupsCellIdentifier,
            for: indexPath
        ) as? GroupTableViewCell else { return UITableViewCell() }
        cell.configure(searchResult[indexPath.row], networkService: networkService)

        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        searchResult.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        searchBar
    }
}

// MARK: - UISearchBarDelegate

extension UserGroupsTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResult = groups
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResult = searchText.isEmpty ? groups : groups.filter { group -> Bool in
            group.name.range(of: searchText, options: .caseInsensitive) != nil
        }
        tableView.reloadData()
    }
}
