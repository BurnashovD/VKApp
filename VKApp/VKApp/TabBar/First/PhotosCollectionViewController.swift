// PhotosCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран фотографий пользователя
final class PhotosCollectionViewController: UICollectionViewController {
    // MARK: - Private properties

    private var image = UIImage()
    private var userPhotosNames: [String] = []

    // MARK: - Public methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.phototAnimationSegueIdentifier,
              let photoCollection = segue.destination as? FriendsPhotosViewController,
              let images = sender as? [String] else { return }
        photoCollection.getUsersPhotoNames(images)
    }

    func getUserPhotoNames(_ photosNames: [String], profilePhoto: UIImage) {
        image = profilePhoto
        userPhotosNames = photosNames
    }
}

/// Constants
extension PhotosCollectionViewController {
    enum Constants {
        static let photosCellIdentifier = "photos"
        static let phototAnimationSegueIdentifier = "photoAnimation"
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

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.phototAnimationSegueIdentifier, sender: userPhotosNames)
    }
}
