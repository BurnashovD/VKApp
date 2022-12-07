// PostTextTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Текст поста
final class PostTextTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var postTextView: UITextView!
    @IBOutlet private var postView: UIView!

    // MARK: - Public methods

    func configure(_ post: PostItem) {
        postTextView.text = post.text
    }
}
