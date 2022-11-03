// PhotosCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var userPhotoImageView: UIImageView!

    func refresh(pvc: PhotosCollectionViewController) {
        userPhotoImageView.image = pvc.image
    }
}
