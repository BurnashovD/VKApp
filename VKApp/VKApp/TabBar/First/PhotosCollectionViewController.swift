// PhotosCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Экран фотографий пользователя
final class PhotosCollectionViewController: UICollectionViewController {
    // MARK: - Private properties

    private let networkService = NetworkService()

    private var photosUrlPath: [String] = []
    private var userId = 0
    private var images: [UIImage] = [] {
        willSet {
            collectionView.reloadData()
        }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
    }

    // MARK: - Public methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.phototAnimationSegueIdentifier,
              let photoCollection = segue.destination as? FriendsPhotosViewController,
              let images = sender as? [UIImage] else { return }
        photoCollection.getUsersPhotoNames(images)
    }

    func getUserId(id: Int) {
        userId = id
    }

    // MARK: - Private methods

    private func fetchPhotos() {
        networkService.fetchPhotos(
            Constants.getPhotosMethodName,
            String(userId)
        ) { [weak self] item in
            guard let self = self else { return }
            self.photosUrlPath = item
            self.fetchImages()
        }
    }

    private func fetchImages() {
        photosUrlPath.forEach { url in
            fetchUserPhotos(url) { item in
                self.images.append(item)
            }
        }
    }
}

/// Constants
extension PhotosCollectionViewController {
    private enum Constants {
        static let photosCellIdentifier = "photos"
        static let phototAnimationSegueIdentifier = "photoAnimation"
        static let getPhotosMethodName = "photos.get"
        static let ownerIdParametrName = "owner_id"
        static let albumIdParametrName = "album_id"
        static let profileParametrName = "profile"
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension PhotosCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.photosCellIdentifier,
            for: indexPath
        ) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(images[indexPath.row])
        cell.animatePhotosCellsAction()
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.phototAnimationSegueIdentifier, sender: images)
    }
}
