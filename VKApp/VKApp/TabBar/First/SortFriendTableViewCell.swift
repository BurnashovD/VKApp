// SortFriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка друга пользователя
final class SortFriendTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    // MARK: - Private properties

    private lazy var tapImageGestureRecognizer = UITapGestureRecognizer()

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configCell()
    }

    func configure(name: String, image: UIImage) {
        nameLabel.text = name
        profileImageView.image = image
    }

    // MARK: - Private methods

    private func configCell() {
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.isUserInteractionEnabled = true
        tapImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateProfileImageAction))
        profileImageView.addGestureRecognizer(tapImageGestureRecognizer)
    }

    @objc private func animateProfileImageAction() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3) {
            self.profileImageView.bounds = CGRect(
                x: self.profileImageView.center.x,
                y: self.profileImageView.center.y,
                width: 60,
                height: 60
            )
        }
    }
}
