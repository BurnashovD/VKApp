// StoriesCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class StoriesCollectionView: UICollectionView {
    var stories: [Storie] = []

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createStories()
        delegate = self
        dataSource = self
    }

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
    }
}

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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storie", for: indexPath) as? StorieCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(stories[indexPath.row])
        cell.configCell()
        return cell
    }
}
