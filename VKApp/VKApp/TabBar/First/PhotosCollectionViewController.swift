// PhotosCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран фотографий пользователя
final class PhotosCollectionViewController: UICollectionViewController {
    // MARK: - Public properties

    var image = UIImage()
}

/// Constants
extension PhotosCollectionViewController {
    enum Constants {
        static let photosCellIdentifier = "photos"
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

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
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.photosCellIdentifier,
            for: indexPath
        ) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(image)
        cell.animatePhotosCellsAction()
        return cell
    }
}
