// StorieCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с историей
final class StorieCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var underStorieView: UIView!
    @IBOutlet private var profilePhotoImageView: UIImageView!
    @IBOutlet private var profileNameLabel: UILabel!

    // MARK: - Public methods

    func configure(_ storie: Storie) {
        profilePhotoImageView.image = UIImage(named: storie.profileImageName)
        profileNameLabel.text = storie.profileName
    }

    func configCell() {
        underStorieView.layer.cornerRadius = underStorieView.frame.size.height / 2
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.frame.size.height / 2
        profilePhotoImageView.layer.borderColor = UIColor.black.cgColor
        profilePhotoImageView.layer.borderWidth = 2
    }
}
