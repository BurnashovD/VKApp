// FriendsPhotosViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Просмотр фото
final class FriendsPhotosViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var photosScrollView: UIScrollView!
    @IBOutlet private var firstImageView: UIImageView!
    @IBOutlet private var secondImageView: UIImageView!
    @IBOutlet private var thirdImageView: UIImageView!

    // MARK: - Private properties

    private var userPhotosNames: [String?] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setImages()
        addSwipeGesture()
    }

    // MARK: - Public methods

    func getUsersPhotoNames(_ photos: [String]) {
        userPhotosNames = photos
    }

    // MARK: - Private methods

    private func setImages() {
        guard let firstImage = userPhotosNames[0], let secondImage = userPhotosNames[1],
              let thirdImage = userPhotosNames[2] else { return }
        firstImageView.image = UIImage(named: firstImage)
        secondImageView.image = UIImage(named: secondImage)
        thirdImageView.image = UIImage(named: thirdImage)
    }

    private func addSwipeGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(dismissAction))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)
    }

    @objc private func dismissAction(gesture: UIPanGestureRecognizer) {
        let velocity = gesture.velocity(in: view)
        let swipe = velocity.y > 500
        guard swipe else { return }
        dismiss(animated: true)
    }
}

// MARK: - UIScrollViewDelegate

extension FriendsPhotosViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.4) {
            let transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.firstImageView.transform = transform
            self.secondImageView.transform = transform
            self.thirdImageView.transform = transform
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        UIView.animate(withDuration: 0.4) {
            self.firstImageView.transform = .identity
            self.secondImageView.transform = .identity
            self.thirdImageView.transform = .identity
        }
    }
}
