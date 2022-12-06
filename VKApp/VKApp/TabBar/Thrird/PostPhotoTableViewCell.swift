// PostPhotoTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class PostPhotoTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var postPhotoImageView: UIImageView!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(_ post: Post) {
        postPhotoImageView.image = UIImage(named: post.postImageName)
    }
}
