// LoadingDotsView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Анимация загрузки
final class LoadingDotsView: UIView {
    // MARK: - Visual components

    private let dotsStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let firstDotView = UIView()
    private let secondDotView = UIView()
    private let thirdDotView = UIView()

    // MARK: - Private properties

    private lazy var dots = [firstDotView, secondDotView, thirdDotView]

    // MARK: - Public methods

    override func layoutSubviews() {
        super.layoutSubviews()
        configView()
    }

    // MARK: - Private methods

    private func configView() {
        addSubview(dotsStackView)
        configDots()
        createAnimationAction()
        createStackViewAnchors()
    }

    private func configDots() {
        dots.forEach {
            $0.clipsToBounds = true
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .blue
            $0.widthAnchor.constraint(equalToConstant: 15).isActive = true
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor).isActive = true
            dotsStackView.addArrangedSubview($0)
        }
    }

    private func createStackViewAnchors() {
        dotsStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dotsStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    private func createAnimationAction() {
        UIView.animate(withDuration: 0.7, delay: 0, options: [.repeat, .autoreverse]) {
            self.firstDotView.alpha = 0.3
        }

        UIView.animate(withDuration: 0.7, delay: 0.3, options: [.repeat, .autoreverse]) {
            self.secondDotView.alpha = 0.3
        }

        UIView.animate(withDuration: 0.7, delay: 0.6, options: [.repeat, .autoreverse]) {
            self.thirdDotView.alpha = 0.3
        }
    }
}
