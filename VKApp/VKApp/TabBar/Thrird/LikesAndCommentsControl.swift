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
        button.backgroundColor = UIColor(named: Constants.backgroundGrayColorName)
        return button
    }()

    private let commentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: Constants.messageImageName), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        button.backgroundColor = UIColor(named: Constants.backgroundGrayColorName)
        return button
    }()

    private let shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: Constants.forwardImageName), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        button.backgroundColor = UIColor(named: Constants.backgroundGrayColorName)
        return button
    }()

    private let likesCounterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constants.zeroText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(named: Constants.backgroundGrayColorName)
        return label
    }()

    private let postDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(named: Constants.backgroundGrayColorName)
        return label
    }()

    // MARK: - Private properties

    private let dateFormatter: DateFormatter? = {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        return formatter
    }()

    private var dateTextCache: [IndexPath: String] = [:]
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

    // MARK: - Public methods

    func configure(_ post: PostItem, indexPath: IndexPath) {
        postDateLabel.text = getCellDateText(indexPath: indexPath, time: Double(post.date))
    }

    // MARK: - Private methods

    private func configControl() {
        backgroundColor = UIColor(named: Constants.backgroundGrayColorName)
        frame = bounds
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        addSubview(likesCounterLabel)
        addSubview(postDateLabel)
        createLikeButtonAnchors()
        createCounterAnchors()
        createCommentButtonAchors()
        createShareButtonAnchors()
        createPostDateLableAnchors()
        likeButton.addTarget(self, action: #selector(tapOnLikeAction), for: .touchUpInside)
    }

    private func getCellDateText(indexPath: IndexPath, time: Double) -> String {
        guard let stringDate = dateTextCache[indexPath] else {
            let date = Date(timeIntervalSince1970: time)
            let stringDate = dateFormatter?.string(from: date)
            dateTextCache[indexPath] = stringDate
            return stringDate ?? ""
        }
        return stringDate
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

    private func createPostDateLableAnchors() {
        postDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        postDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        postDateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        postDateLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
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
        static let dateFormat = "dd.MM.yyyy HH.mm"
    }
}
