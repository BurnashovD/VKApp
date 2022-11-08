// SortFriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка друга пользователя
final class SortFriendTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configCell()
    }

    // MARK: - Private methods

    private func configCell() {
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    }
}
