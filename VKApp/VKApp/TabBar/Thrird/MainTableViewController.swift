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
            postImageName: Constants.dogImageName
        )
        let secondPost = Post(
            profileImageName: Constants.dogImageName,
            userName: Constants.secondProfileName,
            overview: Constants.overviewText,
            postImageName: Constants.secondElonImageName
        )
        let thirdPost = Post(
            profileImageName: Constants.steveImageName,
            userName: Constants.thirdProfileName,
            overview: Constants.overviewText,
            postImageName: Constants.steveImageName
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
        16
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView
//            .dequeueReusableCell(
//                withIdentifier: Constants.postsCellIdentifier,
//                for: indexPath
//            ) as? PostsTableViewCell
//        else { return UITableViewCell() }
//        cell.configure(posts[indexPath.row])
//        cell.callActivityHandler = { items in
//            self.callActivityAction(items: items)
//        }
//        return cell
        let type = cellTypes[indexPath.row]
        switch type {
        case .author:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: "author",
                    for: indexPath
                ) as? AuthorTableViewCell
            else { return UITableViewCell() }
            cell.configure(posts[indexPath.row])
            return cell

        case .overview:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: "postText",
                    for: indexPath
                ) as? PostTextTableViewCell
            else { return UITableViewCell() }
            cell.configure(posts[indexPath.row])
            return cell
        case .postImage:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: "postPhoto",
                    for: indexPath
                ) as? PostPhotoTableViewCell
            else { return UITableViewCell() }
            cell.configure(posts[indexPath.row])
            return cell
        case .likes:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: "likes",
                    for: indexPath
                ) as? LikesTableViewCell
            else { return UITableViewCell() }
            print("hihi")
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
