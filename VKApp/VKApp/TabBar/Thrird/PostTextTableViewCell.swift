// PostTextTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class PostTextTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var postTextView: UITextView!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(_ post: Post) {
        postTextView.text = post.overview
    }
}
