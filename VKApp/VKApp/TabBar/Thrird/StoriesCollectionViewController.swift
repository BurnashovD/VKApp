// StoriesCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Коллекция сторис
final class StoriesCollectionView: UICollectionView {
    // MARK: - Private properties

    private var stories: [Storie] = []

    // MARK: - init

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        subscribeCollectionOnProtocols()
        createStories()
    }

    // MARK: - Private methods

    private func createStories() {
        let firstStorie = Storie(
            profileImageName: Constants.firstProfileImageName,
            profileName: Constants.firstProfileName
        )
        let secondStorie = Storie(
            profileImageName: Constants.secondProfileImageName,
            profileName: Constants.secondProfileName
        )
        let thirdStorie = Storie(
            profileImageName: Constants.thirdProfileImageName,
            profileName: Constants.thirdProfileName
        )

        for _ in 0 ... 3 {
            stories.append(firstStorie)
            stories.append(secondStorie)
            stories.append(thirdStorie)
        }
    }

    private func subscribeCollectionOnProtocols() {
        dataSource = self
    }
}

/// Constants
extension StoriesCollectionView {
    enum Constants {
        static let firstProfileImageName = "dogg"
        static let secondProfileImageName = "em3"
        static let thirdProfileImageName = "pizza"
        static let firstProfileName = "@lowbattery_o"
        static let secondProfileName = "@kvakva01"
        static let thirdProfileName = "@blabla13"
        static let storieCellIdentifier = "storie"
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension StoriesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stories.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(
                withReuseIdentifier: Constants.storieCellIdentifier,
                for: indexPath
            ) as? StorieCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configure(stories[indexPath.row])
        cell.configCell()
        return cell
    }
}
