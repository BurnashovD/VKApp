// GlobalSearchTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Глобальный поиск
final class GlobalSearchTableViewController: UITableViewController {
    // MARK: - Visual components

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: Constants.searchBarPlaceholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        searchBar.delegate = self
        return searchBar
    }()

    // MARK: - Public properties

    var globalGroups: [Group] = []

    // MARK: - Private properties

    private let networkService = NetworkService()

    private var searchedGroups: [Groups] = []
    private var groups: [Groups] = []

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
}

/// Constants
extension GlobalSearchTableViewController {
    private enum Constants {
        static let globalGroupsCellIdentifier = "globalGroup"
        static let profileImageName = "profile"
        static let chooseGroupNameText = "Введите название группы"
        static let okText = "Ок"
        static let methodName = "groups.search"
        static let searchBarPlaceholderText = " Поиск..."
        static let qParametrName = "q"
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
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.globalGroupsCellIdentifier,
            for: indexPath
        ) as? GlobalGroupsTableViewCell else { return UITableViewCell() }
        cell.configure(groups[indexPath.row])

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

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        searchBar
    }
}

// MARK: - UISearchBarDelegate

extension GlobalSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedGroups = searchText.isEmpty ? [] : groups.filter { group -> Bool in
            group.name.range(of: searchText, options: .caseInsensitive) != nil
        }
        networkService.fetchGroup(
            Constants.methodName,
            parametrMap: [
                Constants.qParametrName: searchText,
                Constants.typeparametrName: Constants.groupTypeName
            ]
        ) { [weak self] items in
            guard let self = self else { return }
            self.groups = items
            self.tableView.reloadData()
        }
        tableView.reloadData()
    }
}
