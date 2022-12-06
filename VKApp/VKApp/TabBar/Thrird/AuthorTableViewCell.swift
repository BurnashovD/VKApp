// AuthorTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Автора поста
final class AuthorTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var profilePhotoImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var authorView: UIView!

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configPostView()
    }

    func configure(_ post: Post) {
        profilePhotoImageView.image = UIImage(named: post.profileImageName)
        userNameLabel.text = post.userName
    }

    // MARK: - Private methods

    private func configPostView() {
        authorView.layer.cornerRadius = 10
        authorView.layer.shadowColor = UIColor.white.cgColor
        authorView.layer.shadowOffset = CGSize(width: 0, height: 0)
        authorView.layer.shadowRadius = 5
        authorView.layer.shadowOpacity = 0.6
        configProfileImageView()
    }

    private func configProfileImageView() {
        profilePhotoImageView.clipsToBounds = true
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.frame.height / 2
    }
}
