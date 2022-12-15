// MainTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таблица новостей
final class MainTableViewController: UITableViewController {
    // MARK: - Visual components

    private let postRefreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .white
        return refresh
    }()

    // MARK: - Private properties

    private let cellTypes: [CellTypes] = [.author, .overview, .postImage, .likes]
    private let networkService = NetworkService()

    private lazy var photoCacheService = PhotoCacheService(container: tableView)
    private var posts: [Post] = []
    private var postsItems: [PostItem] = []
    private var profiles: [UserItem] = []
    private var groups: [GroupItem] = []
    private var photoSizes: [PhotoSizes] = []
    private var nextPost = ""
    private var isLoading = false

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        fetchPosts()
    }

    // MARK: - Private methods

    private func configUI() {
        view.addSubview(postRefreshControl)
        postRefreshControl.addTarget(self, action: #selector(refreshNewsfeedAction), for: .valueChanged)
    }

    private func fetchPosts() {
        networkService.fetchPosts(Constants.newsFeedMethodName) { [weak self] result in
            switch result {
            case let .fulfilled(items):
                guard let item = items.items, let post = items.nextPost, let self = self else { return }
                self.postsItems = item
                self.nextPost = post
                self.fetchPostsProfiles()
            case let .rejected(error):
                print(error.localizedDescription)
            }
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
        filterPostPhoto()
    }

    private func filterPostPhoto() {
        postsItems.forEach { post in
            let sizes = post.sizes?.filter { item in
                item.type == Constants.rPhotoTypeName
            }.first
            guard let size = sizes?.url else { return }
            post.currentPhoto = size
        }
    }

    private func getRefreshedNews(_ items: [PostItem]) {
        postRefreshControl.endRefreshing()
        postsItems = items + postsItems
        filterAuthorItems()
        tableView.reloadData()
    }

    private func getForwardPosts(_ oldPostsCount: Int) {
        isLoading = true
        networkService.fetchRefreshedPosts(Constants.newsFeedMethodName, startFrom: nextPost) { [weak self] result in
            switch result {
            case let .fulfilled(item):
                guard let self = self, let post = item.items else { return }
                let newSections = (oldPostsCount ..< (oldPostsCount + post.count)).map { $0 }
                self.postsItems.append(contentsOf: post)
                self.filterAuthorItems()
                self.tableView.insertSections(IndexSet(newSections), with: .automatic)
                self.isLoading = false
            case let .rejected(error):
                print(error.localizedDescription)
            }
        }
    }

    private func fetchRefreshedPosts(_ freshDate: TimeInterval) {
        networkService
            .fetchRefreshedPosts(Constants.newsFeedMethodName, startTime: freshDate) { [weak self] result in
                switch result {
                case let .fulfilled(post):
                    guard
                        let self = self,
                        let items = post.items
                    else { return }
                    self.getRefreshedNews(items)
                case let .rejected(error):
                    print(error.localizedDescription)
                }
            }
    }

    @objc private func refreshNewsfeedAction() {
        var freshDate: TimeInterval?

        guard let firstItem = postsItems.first?.date else { return }
        freshDate = Double(firstItem) + 1
        fetchRefreshedPosts(freshDate ?? 0)
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
        static let photoText = "photo"
        static let loadingText = "Loading..."
        static let rPhotoTypeName = "r"
    }

    enum CellTypes {
        case author
        case overview
        case postImage
        case likes
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching

extension MainTableViewController: UITableViewDataSourcePrefetching {
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard !postsItems.isEmpty else {
            tableView.showEmptyMessage(Constants.loadingText)
            return 0
        }
        tableView.hideEmptyMessage()
        return postsItems.count
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
            let post = postsItems[indexPath.section]
            if post.url != "", post.type == Constants.photoText {
                guard let cell = tableView
                    .dequeueReusableCell(
                        withIdentifier: Constants.postPhotoCellIdentifier,
                        for: indexPath
                    ) as? PostPhotoTableViewCell
                else { return UITableViewCell() }
                cell.configure(
                    postsItems[indexPath.section],
                    networkService: networkService
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
        let type = cellTypes[indexPath.row]
        let post = postsItems[indexPath.section]
        switch type {
        case .postImage:
            guard post.type == Constants.photoText else { fallthrough }
            let tableWidth = tableView.bounds.width
            let cellHeight = tableWidth * post.aspectRatio
            return cellHeight
        default:
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let oldPostsCount = postsItems.count
        guard
            let maxRow = indexPaths.map(\.section).max(),
            maxRow > postsItems.count - 5,
            isLoading == false
        else { return }
        getForwardPosts(oldPostsCount)
    }
}
