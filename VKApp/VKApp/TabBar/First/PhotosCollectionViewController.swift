// PhotosCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Экран фотографий пользователя
final class PhotosCollectionViewController: UICollectionViewController {
    // MARK: - Private properties

    private let networkService = NetworkService()
    private let realmService = RealmService()

    private var photosUrlPath: [String] = []
    private var photos: [Size] = []
    private var userId = 0

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
    }

    // MARK: - Public methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.phototAnimationSegueIdentifier,
              let photoCollection = segue.destination as? FriendsPhotosViewController,
              let images = sender as? [String] else { return }
        photoCollection.userPhotoPaths = images
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
            self.getPhotosData()
            self.photosUrlPath = item
        }
    }

    private func getPhotosData() {
        realmService.getData(Size.self) { [weak self] photo in
            guard let self = self else { return }
            self.photos = photo
            self.collectionView.reloadData()
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
        photos.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.photosCellIdentifier,
            for: indexPath
        ) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(photos[indexPath.row], networkService: networkService)
        cell.animatePhotosCellsAction()
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.phototAnimationSegueIdentifier, sender: photosUrlPath)
    }
}
