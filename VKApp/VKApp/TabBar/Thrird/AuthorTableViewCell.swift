// AuthorTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AuthorTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var profilePhotoImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(_ post: Post) {
        profilePhotoImageView.image = UIImage(named: post.profileImageName)
        userNameLabel.text = post.userName
    }
}
