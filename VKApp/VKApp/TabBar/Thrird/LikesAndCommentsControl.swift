// LikesAndCommentsControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомный контрол с лайками, комментами
final class LikesAndCommentsControl: UIControl {
    // MARK: - Visual components

    private let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: Constants.heartImageName), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        return button
    }()

    private let commentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: Constants.messageImageName), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        return button
    }()

    private let shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: Constants.forwardImageName), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        return button
    }()

    private let likesCounterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constants.zeroText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Private properties

    private var likesCount = 0
    private var isTapped = false
    private var likeColor: UIColor = .white

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configControl()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configControl()
    }

    // MARK: - Private methods

    private func configControl() {
        backgroundColor = UIColor(named: Constants.backgroundGrayColorName)
        frame = bounds
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        addSubview(likesCounterLabel)
        createLikeButtonAnchors()
        createCounterAnchors()
        createCommentButtonAchors()
        createShareButtonAnchors()
        likeButton.addTarget(self, action: #selector(tapOnLikeAction), for: .touchUpInside)
    }

    private func createLikeButtonAnchors() {
        likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        likeButton.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        likeButton.trailingAnchor.constraint(equalTo: commentButton.leadingAnchor, constant: -50).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func createCommentButtonAchors() {
        commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 50).isActive = true
        commentButton.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        commentButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -50).isActive = true
        commentButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func createShareButtonAnchors() {
        shareButton.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func createCounterAnchors() {
        likesCounterLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        likesCounterLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 7).isActive = true
        likesCounterLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        likesCounterLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    @objc private func tapOnLikeAction() {
        isTapped = !isTapped
        likesCount = isTapped ? 1 : 0
        likeColor = isTapped ? .red : .white
        likeButton.tintColor = likeColor
        UIView.transition(
            with: likesCounterLabel,
            duration: 0.3,
            options: .transitionFlipFromBottom
        ) {
            self.likesCounterLabel.text = String(self.likesCount)
        }
    }
}

/// Constants
extension LikesAndCommentsControl {
    enum Constants {
        static let heartImageName = "heart"
        static let messageImageName = "message"
        static let forwardImageName = "arrowshape.turn.up.forward"
        static let backgroundGrayColorName = "backgroundGray"
        static let zeroText = "0"
    }
}
