// MainTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таблица новостей
final class MainTableViewController: UITableViewController {
    // MARK: - Private properties

    private let cellTypes: [CellTypes] = [.stories, .posts]

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
    enum Constants {
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
        case stories
        case posts
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = cellTypes[section]
        switch type {
        case .stories:
            return 1
        case .posts:
            return posts.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = cellTypes[indexPath.section]
        switch type {
        case .stories:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: Constants.storiesCellIdentifier,
                    for: indexPath
                ) as? StoriesTableViewCell
            else { return UITableViewCell() }

            return cell
        case .posts:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: Constants.postsCellIdentifier,
                    for: indexPath
                ) as? PostsTableViewCell
            else { return UITableViewCell() }
            cell.configure(posts[indexPath.row])
            cell.callActivityAction = { items in
                self.callActivityAction(items: items)
            }
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
