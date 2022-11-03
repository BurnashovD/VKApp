// PhotosCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка фотографии с коллекции
final class PhotosCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var userPhotoImageView: UIImageView!

    // MARK: - Public methods

    func refresh(pvc: PhotosCollectionViewController) {
        userPhotoImageView.image = pvc.image
    }
}
