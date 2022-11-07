// LikesControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Контрол с подсчетом лайков
@IBDesignable final class LikesControl: UIControl {
    // MARK: - Visual components

    private let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: Constants.hearthImageName), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var likesCounterLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.zeroText
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Private properties

    private var likesCount = 0
    private var isTapped = false
    private var likeImageName = ""
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
        addSubview(likeButton)
        addSubview(likesCounterLabel)
        createLabelAnchors()
        createButtonAnchors()
        likeButton.addTarget(self, action: #selector(tapOnLikeAction), for: .touchUpInside)
    }

    private func createButtonAnchors() {
        likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1).isActive = true
        likeButton.topAnchor.constraint(equalTo: topAnchor, constant: 1).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func createLabelAnchors() {
        likesCounterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1).isActive = true
        likesCounterLabel.topAnchor.constraint(equalTo: topAnchor, constant: 1).isActive = true
        likesCounterLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor).isActive = true
        likesCounterLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }

    @objc private func tapOnLikeAction() {
        isTapped = !isTapped
        likesCount = isTapped ? 1 : 0
        likeImageName = isTapped ? Constants.heardtFillImageName : Constants.hearthImageName
        likeColor = isTapped ? .red : .white
        likeButton.tintColor = likeColor
        likesCounterLabel.textColor = likeColor
        likeButton.setBackgroundImage(UIImage(systemName: likeImageName), for: .normal)
        likesCounterLabel.text = String(likesCount)
    }
}

// Constants
extension LikesControl {
    enum Constants {
        static let hearthImageName = "heart"
        static let heardtFillImageName = "heart.fill"
        static let zeroText = "0"
    }
}
