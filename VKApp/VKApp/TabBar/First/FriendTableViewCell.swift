// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка профиля друга пользователя
final class FriendTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    var usersImagesNames: [String] = []

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configCell()
    }

    func configure(_ user: User?) {
        guard let name = user?.name, let surname = user?.surname,
              let image = user?.profileImageName.first,
              let photos = user?.profileImageName else { return }
        usersImagesNames = photos
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
