// MainTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таблица новостей
final class MainTableViewController: UITableViewController {
    // MARK: - Private properties

    private let cellTypes: [CellTypes] = [.author, .overview, .postImage, .likes]
    private let networkService = NetworkService()

    private var posts: [Post] = []
    private var postsItems: [PostItems] = []
    private var profiles: [Item] = []
    private var groups: [Groups] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }

    // MARK: - Private methods

    private func fetchPosts() {
        networkService.fetchPosts(Constants.newsFeedMethodName) { [weak self] items in
            guard let item = items.items, let self = self else { return }
            self.postsItems = item
            self.fetchPostsProfiles()
        }
    }

    private func fetchPostsProfiles() {
        networkService.fetchPostsProfiles(Constants.newsFeedMethodName) { [weak self] item in
            guard let self = self, let profile = item.profile, let group = item.group else { return }
            self.profiles = profile
            self.groups = group
            self.tableView.reloadData()
        }
    }
}

/// Constants and CellTypes
extension MainTableViewController {
    private enum Constants {
        static let storiesCellIdentifier = "stories"
        static let postsCellIdentifier = "post"
        static let secondElonImageName = "secondElon"
        static let steveImageName = "steve"
        static let dogImageName = "dogg"
        static let firstProfileName = "@lowbattery_o"
        static let secondProfileName = "@kvakva01"
        static let thirdProfileName = "@blabla13"
        static let overviewText = """
        Создать экран новостей. Добавить туда таблицу и сделать ячейку для новости. Ячейка должна содержать то же самое, что и в оригинальном приложении «ВКонтакте»: надпись, фотографии, кнопки.
        """
        static let authorCellIdentifier = "author"
        static let postTextCellIdentifier = "postText"
        static let postPhotoCellIdentifier = "postPhoto"
        static let emptyCellIdentifier = "empty"
        static let likesCellIdentifier = "likes"
        static let videoText = "video"
        static let newsFeedMethodName = "newsfeed.get"
    }

    enum CellTypes {
        case author
        case overview
        case postImage
        case likes
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        postsItems.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = cellTypes[indexPath.row]
        switch type {
        case .author:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: Constants.authorCellIdentifier,
                    for: indexPath
                ) as? AuthorTableViewCell
            else { return UITableViewCell() }
            if postsItems[indexPath.section].ownerId >= 0 {
                cell.configureUser(
                    postsItems[indexPath.section],
                    profiles[indexPath.row],
                    networkService: networkService
                )
            } else {
                cell.configureGroup(
                    postsItems[indexPath.section],
                    groups[indexPath.section],
                    networkService: networkService
                )
            }
            return cell

        case .overview:
            if postsItems[indexPath.section].text.isEmpty {
                guard let cell = tableView
                    .dequeueReusableCell(
                        withIdentifier: Constants.postTextCellIdentifier,
                        for: indexPath
                    ) as? PostTextTableViewCell
                else { return UITableViewCell() }
                cell.configure(postsItems[indexPath.section])
                return cell
            } else {
                guard let cell = tableView
                    .dequeueReusableCell(
                        withIdentifier: Constants.emptyCellIdentifier,
                        for: indexPath
                    ) as? EmptyTableViewCell
                else { return UITableViewCell() }
                return cell
            }
        case .postImage:
            if postsItems[indexPath.section].url != "" {
                guard let cell = tableView
                    .dequeueReusableCell(
                        withIdentifier: Constants.postPhotoCellIdentifier,
                        for: indexPath
                    ) as? PostPhotoTableViewCell
                else { return UITableViewCell() }
                cell.configure(postsItems[indexPath.section], networkService: networkService)
                return cell
            } else {
                guard let cell = tableView
                    .dequeueReusableCell(
                        withIdentifier: Constants.emptyCellIdentifier,
                        for: indexPath
                    ) as? EmptyTableViewCell
                else { return UITableViewCell() }
                return cell
            }

        case .likes:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: Constants.likesCellIdentifier,
                    for: indexPath
                ) as? LikesTableViewCell
            else { return UITableViewCell() }
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
