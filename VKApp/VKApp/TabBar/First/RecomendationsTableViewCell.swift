// RecomendationsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с рекомендацией
final class RecomendationsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configCell()
    }

    func configure(_ user: UserItem) {
        profileImageView.image = UIImage(named: user.photo)
        nameLabel.text = "\(user.firstName) \(user.lastName)"
    }

    // MARK: - Private methods

    private func configCell() {
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    }
}
