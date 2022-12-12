// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Ячейка профиля друга пользователя
final class FriendTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    // MARK: - Public properties

    var userId = 0

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configCell()
    }

    func configure(
        _ user: UserItem,
        photoService: PhotoCacheService
    ) {
        let url = user.photo
        profileImageView.image = photoService.photo(byUrl: url)
        nameLabel.text = "\(user.firstName) \(user.lastName)"
        userId = user.userId
    }

    // MARK: - Private methods

    private func configCell() {
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    }
}
