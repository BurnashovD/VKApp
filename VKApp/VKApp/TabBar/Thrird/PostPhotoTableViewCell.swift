// PostPhotoTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Изображение поста
final class PostPhotoTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var postPhotoImageView: UIImageView!
    @IBOutlet private var postView: UIView!

    // MARK: - Public methods

    func configure(
        _ post: PostItem,
        photoService: PhotoCacheService
    ) {
        postPhotoImageView.image = photoService.photo(byUrl: post.url)
    }
}
