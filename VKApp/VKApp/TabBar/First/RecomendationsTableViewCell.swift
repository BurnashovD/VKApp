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

    func configure(_ user: User?) {
        guard let image = user?.profileImageName.first, let name = user?.name,
              let surname = user?.surname else { return }
        profileImageView.image = UIImage(named: image)
        nameLabel.text = "\(name) \(surname)"
    }

    // MARK: - Private methods

    private func configCell() {
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    }
}
