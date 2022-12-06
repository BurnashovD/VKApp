// LikesAndCommentsControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class LikesAndCommentsControl: UIControl {
    // MARK: - Visual components

    private let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        return button
    }()

    private let commentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "message"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        return button
    }()

    private let shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "arrowshape.turn.up.forward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        return button
    }()

    private let likesCounterLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        backgroundColor = .black
        frame = bounds
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        addSubview(likesCounterLabel)
        createLikeButtonAnchors()
        createCounterAnchors()
        createCommentButtonAchors()
        createShareButtonAnchors()
    }

    private func createLikeButtonAnchors() {
        likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        likeButton.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        likeButton.trailingAnchor.constraint(equalTo: commentButton.leadingAnchor, constant: -50).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func createCommentButtonAchors() {
        commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 50).isActive = true
        commentButton.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        commentButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -50).isActive = true
        commentButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func createShareButtonAnchors() {
        commentButton.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        commentButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func createCounterAnchors() {
        likesCounterLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        likesCounterLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 7).isActive = true
        likesCounterLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        likesCounterLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
