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

    private var userPhotos: [UIImage]? = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setImages()
        addSwipeGesture()
    }

    // MARK: - Public methods

    func getUsersPhotoNames(_ photos: [UIImage]) {
        userPhotos = photos
    }

    // MARK: - Private methods

    private func setImages() {
        let imageCount = userPhotos?.count
        switch imageCount {
        case 0:
            firstImageView.image = UIImage()
            secondImageView.image = UIImage()
            thirdImageView.image = UIImage()
        case 1:
            guard let firstImage = userPhotos?[0] else { return }
            firstImageView.image = firstImage
        case 2:
            guard let firstImage = userPhotos?[0],
                  let secondImage = userPhotos?[1] else { return }
            firstImageView.image = firstImage
            thirdImageView.image = secondImage
        default:
            guard let firstImage = userPhotos?[0],
                  let secondImage = userPhotos?[1],
                  let thirdImage = userPhotos?[2] else { return }
            firstImageView.image = firstImage
            secondImageView.image = secondImage
            thirdImageView.image = thirdImage
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
