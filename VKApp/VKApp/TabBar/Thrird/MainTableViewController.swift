// MainTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таблица новостей
final class MainTableViewController: UITableViewController {
    // MARK: - Private properties

    private let cellTypes: [CellTypes] = [.author, .overview, .postImage, .likes]

    private var posts: [Post] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createPosts()
    }

    // MARK: - Private methods

    private func createPosts() {
        let firstPost = Post(
            profileImageName: Constants.secondElonImageName,
            userName: Constants.firstProfileName,
            overview: Constants.overviewText,
            postImageName: Constants.dogImageName,
            postType: true
        )
        let secondPost = Post(
            profileImageName: Constants.dogImageName,
            userName: Constants.secondProfileName,
            overview: Constants.overviewText,
            postImageName: Constants.secondElonImageName,
            postType: true
        )
        let thirdPost = Post(
            profileImageName: Constants.steveImageName,
            userName: Constants.thirdProfileName,
            overview: Constants.overviewText,
            postImageName: Constants.steveImageName,
            postType: false
        )

        for _ in 0 ... 3 {
            posts.append(firstPost)
            posts.append(secondPost)
            posts.append(thirdPost)
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
        posts.count * cellTypes.count
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
            cell.configure(posts[indexPath.section])
            return cell

        case .overview:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: Constants.postTextCellIdentifier,
                    for: indexPath
                ) as? PostTextTableViewCell
            else { return UITableViewCell() }
            cell.configure(posts[indexPath.section])
            return cell

        case .postImage:
            if posts[indexPath.section].postType == true {
                guard let cell = tableView
                    .dequeueReusableCell(
                        withIdentifier: Constants.postPhotoCellIdentifier,
                        for: indexPath
                    ) as? PostPhotoTableViewCell
                else { return UITableViewCell() }
                cell.configure(posts[indexPath.section])
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
