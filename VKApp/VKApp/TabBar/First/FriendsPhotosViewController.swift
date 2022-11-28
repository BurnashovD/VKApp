// FriendsPhotosViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Показ фото на Скролл вью
final class FriendsPhotosViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var photosScrollView: UIScrollView!
    @IBOutlet private var firstImageView: UIImageView!
    @IBOutlet private var secondImageView: UIImageView!
    @IBOutlet private var thirdImageView: UIImageView!

    // MARK: - Private properties

    private lazy var imageViews = [firstImageView, secondImageView, thirdImageView]
    private var userPhotoImages: [UIImage]? = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipeGesture()
        setImages()
    }

    // MARK: - Public methods

    func getUsersPhotoNames(_ photos: [UIImage]) {
        userPhotoImages = photos
    }

    // MARK: - Private methods

    private func setImages() {
        let maxValue = imageViews.count
        guard let count = userPhotoImages?.count else { return }
        for index in 0 ... count - 1 {
            if index >= maxValue {
                return
            } else {
                imageViews[index]?.image = userPhotoImages?[index]
            }
        }
    }

    private func addSwipeGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(dismissAction))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)
    }

    @objc private func dismissAction(gesture: UIPanGestureRecognizer) {
        let velocity = gesture.velocity(in: view)
        let swipe = velocity.y > Constants.swipeVelocityNymber
        guard swipe else { return }
        dismiss(animated: true)
    }
}

/// Constants
extension FriendsPhotosViewController {
    private enum Constants {
        static let swipeVelocityNymber: CGFloat = 500
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
