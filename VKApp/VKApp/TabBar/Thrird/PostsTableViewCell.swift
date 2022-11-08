// PostsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с постом
final class PostsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var postView: UIView!
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var owerviewLabel: UILabel!
    @IBOutlet private var postImageView: UIImageView!

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configPostView()
        configOverviewLabel()
        configProfileImageView()
    }

    func configure(_ post: Post?) {
        guard let profileImage = post?.profileImageName, let name = post?.userName, let overview = post?.overview,
              let postImage = post?.postImageName else { return }
        profileImageView.image = UIImage(named: profileImage)
        userNameLabel.text = name
        owerviewLabel.text = overview
        postImageView.image = UIImage(named: postImage)
    }

    // MARK: - Private methods

    private func configPostView() {
        postView.layer.cornerRadius = 10
        postView.layer.shadowColor = UIColor.white.cgColor
        postView.layer.shadowOffset = CGSize(width: 0, height: 0)
        postView.layer.shadowRadius = 10
        postView.layer.shadowOpacity = 0.6
    }

    private func configOverviewLabel() {
        owerviewLabel.adjustsFontSizeToFitWidth = true
        owerviewLabel.numberOfLines = 0
        owerviewLabel.minimumScaleFactor = 0.1
    }

    private func configProfileImageView() {
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
}
