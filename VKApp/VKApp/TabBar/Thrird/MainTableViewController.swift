// MainTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таблица новостей
final class MainTableViewController: UITableViewController {
    // MARK: - Private properties

    private let cellTypes: [CellTypes] = [.author, .overview, .postImage, .likes]
    private let networkService = NetworkService()

    private lazy var photoCacheService = PhotoCacheService(container: tableView)
    private var posts: [Post] = []
    private var postsItems: [PostItem] = []
    private var profiles: [UserItem] = []
    private var groups: [GroupItem] = []

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
            guard let self = self, let profile = item.profiles, let group = item.groups else { return }
            self.profiles = profile
            self.groups = group
            self.filterAuthorItems()
            self.tableView.reloadData()
        }
    }

    private func filterAuthorItems() {
        postsItems.forEach { post in
            if post.ownerId < 0 {
                let group = groups.filter { group in
                    group.id == post.ownerId * -1
                }.first
                guard let name = group?.name, let photo = group?.photo else { return }
                post.name = name
                post.profileImage = photo
            } else {
                let user = profiles.filter { profile in
                    profile.userId == post.ownerId
                }.first
                guard let name = user?.firstName, let surname = user?.lastName, let photo = user?.photo else { return }
                post.name = "\(name) \(surname)"
                post.profileImage = photo
            }
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
                    networkService: networkService
                )
            } else {
                cell.configureGroup(
                    postsItems[indexPath.section],
                    networkService: networkService
                )
            }
            return cell

        case .overview:
            if !postsItems[indexPath.section].text.isEmpty {
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
                cell.configure(
                    postsItems[indexPath.section],
                    photoService: photoCacheService
                )
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
            cell.configure(postsItems[indexPath.section], indexPath: indexPath)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
