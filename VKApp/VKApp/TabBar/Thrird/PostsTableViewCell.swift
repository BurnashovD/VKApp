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
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var likeCountLabel: UILabel!
    @IBOutlet private var shareButton: UIButton!

    // MARK: - Private properties

    private var isTapped = false
    private var likesCount = 0
    private var likeImageName = ""
    private var likeColor: UIColor = .white

    // MARK: - Public properties

    var callActivityHandler: (([Any]) -> Void)?

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configCell()
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

    private func configCell() {
        configPostView()
        configOverviewLabel()
        configProfileImageView()
        likeButton.addTarget(self, action: #selector(tapOnLikeAction), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(sharePostAction), for: .touchUpInside)
    }

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

    @objc private func tapOnLikeAction() {
        isTapped = !isTapped
        likesCount = isTapped ? 1 : 0
        likeColor = isTapped ? .red : .white
        likeCountLabel.textColor = likeColor
        UIView.transition(
            with: likeCountLabel,
            duration: 0.3,
            options: .transitionFlipFromTop
        ) {
            self.likeCountLabel.text = String(self.likesCount)
        }
    }

    @objc private func sharePostAction() {
        guard let image = profileImageView.image, let text = owerviewLabel.text else { return }
        callActivityHandler?([image, text])
    }
}

/// Constants
extension PostsTableViewCell {
    private enum Constants {
        static let heardtFillImageName = "heart.fill"
        static let hearthImageName = "heart"
    }
}
