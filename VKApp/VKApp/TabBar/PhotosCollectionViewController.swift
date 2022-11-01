// PhotosCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Класс отвечает за коллекцию фотографий пользователя
final class PhotosCollectionViewController: UICollectionViewController {
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

/// Constants
extension PhotosCollectionViewController {
    enum Constants {
        static let photosCellIdentifier = "photos"
    }
}

// MARK: - UICollectionViewDataSource

extension PhotosCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        50
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.photosCellIdentifier,
            for: indexPath
        )

        return cell
    }
}
