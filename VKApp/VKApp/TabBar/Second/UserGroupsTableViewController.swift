// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
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

    private var notificationToken: NotificationToken?
    private var groupsResults: Results<GroupItem>?
    private var searchResult: [GroupItem] = []
    private var groups: [GroupItem] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configController()
        fetchGroups()
        addNotificationToken()
    }

    // MARK: - Private methods

    private func configController() {
        searchBar.delegate = self
    }

    private func fetchGroups() {
        let operationQueue = OperationQueue()

        let fetchOperation = FetchGroupOperation()
        operationQueue.addOperation(fetchOperation)

        let parseOperation = ParseGroupsDataOperation()
        parseOperation.addDependency(fetchOperation)
        operationQueue.addOperation(parseOperation)

        let saveOperation = SaveGroupOperation()
        saveOperation.completionBlock = {
            OperationQueue.main.addOperation {
                self.loadGroupItem()
            }
        }
        saveOperation.addDependency(parseOperation)
        operationQueue.addOperation(saveOperation)
    }

    private func loadGroupItem() {
        realmService.loadData(GroupItem.self) { [weak self] group in
            guard let self = self else { return }
            self.groupsResults = group
            self.groups = Array(self.groupsResults ?? group)
            self.searchResult = self.groups
            self.tableView.reloadData()
        }
    }

    private func addNotificationToken() {
        loadGroupItem()
        notificationToken = groupsResults?.observe { [weak self] (changes: RealmCollectionChange) in
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
                print(error.localizedDescription)
            }
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
        groupsResults?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.groupsCellIdentifier,
            for: indexPath
        ) as? GroupTableViewCell, let result = groupsResults else { return UITableViewCell() }
        cell.configure(result[indexPath.row], networkService: networkService)

        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete, let result = groupsResults else { return }
        realmService.deleteRowAction(result[indexPath.row])
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
