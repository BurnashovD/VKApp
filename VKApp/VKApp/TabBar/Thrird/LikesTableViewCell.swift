// LikesTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Лайки и комментарии
final class LikesTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var customLikesControl: LikesAndCommentsControl!

    // MARK: - Public methods

    func configure(_ post: PostItem, indexPath: IndexPath) {
        customLikesControl.configure(post, indexPath: indexPath)
    }
}
