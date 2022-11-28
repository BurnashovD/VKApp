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

    // MARK: - Private properties

    private let networkService = NetworkService()

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configCell()
    }

    func configure(_ user: Item) {
        let url = user.photo
        networkService.fetchProfilePhotos(url) { [weak self] item in
            self?.profileImageView.image = item
        }
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
