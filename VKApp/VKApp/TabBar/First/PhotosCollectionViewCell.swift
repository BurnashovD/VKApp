// PhotosCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка фотографии с коллекции
final class PhotosCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var userPhotoImageView: UIImageView!

    // MARK: - Private properties

    private var photosImages: [UIImage] = []

    // MARK: - Public methods

    func animatePhotosCellsAction() {
        let opacityAnimate = CABasicAnimation(keyPath: Constants.opacityAnimationKeyPath)
        opacityAnimate.fromValue = 0
        opacityAnimate.toValue = 1
        opacityAnimate.duration = 1.5
        opacityAnimate.fillMode = .forwards
        userPhotoImageView.layer.add(opacityAnimate, forKey: nil)

        let sizeAnimate = CABasicAnimation(keyPath: Constants.cornerRadiusAnimationKeyPath)
        sizeAnimate.fromValue = 50
        sizeAnimate.toValue = 0
        sizeAnimate.duration = 1.5
        userPhotoImageView.layer.add(sizeAnimate, forKey: nil)
    }

    func configure(
        _ imageURL: Size,
        photoService: PhotoCacheService,
        at indexPath: IndexPath
    ) {
        userPhotoImageView.image = photoService.photo(atIndexpath: indexPath, byUrl: imageURL.url)
    }
}

/// Constants
extension PhotosCollectionViewCell {
    private enum Constants {
        static let opacityAnimationKeyPath = "opacity"
        static let cornerRadiusAnimationKeyPath = "cornerRadius"
    }
}
