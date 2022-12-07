// AuthorTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Автора поста
final class AuthorTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var profilePhotoImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var authorView: UIView!
    @IBOutlet private var viewsCountLabel: UILabel!

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configPostView()
    }

    func configureUser(_ post: PostItem, networkService: NetworkService) {
        viewsCountLabel.text = String(post.count)
//        userNameLabel.text = "\(item.firstName) \(item.lastName)"
        userNameLabel.text = post.name
        profilePhotoImageView.fetchUserPhotos(post.profileImage, networkService: networkService)
    }

    func configureGroup(_ post: PostItem, networkService: NetworkService) {
        viewsCountLabel.text = String(post.count)
//        userNameLabel.text = group.name
        userNameLabel.text = post.name
        profilePhotoImageView.fetchUserPhotos(post.profileImage, networkService: networkService)
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
