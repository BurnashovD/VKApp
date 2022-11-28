// SortedFriendsPhotosViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Показ фото на UIPanGestureRecognizer
final class SortedFriendsPhotosViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var friendsPhotoImageview: UIImageView!

    // MARK: - Private properties

    private let swipePropertyAnimator = UIViewPropertyAnimator()
    private let networkService = NetworkService()

    private var index = 0

    // MARK: - Public properties

    private var usersPhotoImages: [UIImage] = []
    private var usersPhotoURLPath: [String] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
        createGestures()
    }

    // MARK: - Private methods

    private func fetchPhotos() {
        networkService.fetchPhotos(
            Constants.getPhotosMethodName,
            String(Session.shared.userId)
        ) { [weak self] items in
            guard let self = self else { return }
            self.usersPhotoURLPath = items
            self.fetchImages()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                guard let photo = self.usersPhotoImages.first else { return }
                self.friendsPhotoImageview.image = photo
                self.friendsPhotoImageview.isUserInteractionEnabled = true
                self.friendsPhotoImageview.setNeedsDisplay()
            }
        }
    }

    private func fetchImages() {
        usersPhotoURLPath.forEach { url in
            fetchUsersPhotos(url) { item in
                self.usersPhotoImages.append(item)
            }
        }
    }

    private func createGestures() {
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeAction(gesture:)))
        friendsPhotoImageview.addGestureRecognizer(swipeGesture)

        let dismissGesture = UIPanGestureRecognizer(target: self, action: #selector(dismissAction))
        view.addGestureRecognizer(dismissGesture)
    }

    private func swipeRightAction(gesture: UIPanGestureRecognizer) {
        guard index != usersPhotoImages.count - 1 else { return }
        switch gesture.state {
        case .began:
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.friendsPhotoImageview.transform = CGAffineTransform(
                    translationX: -Constants.moveViewInXNumber,
                    y: 0
                ).concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
            }
        case .changed:
            let translation = gesture.translation(in: view)
            swipePropertyAnimator.fractionComplete = translation.x / -Constants.moveViewInXNumber
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.friendsPhotoImageview.alpha = 0
            }
        case .ended:
            index += 1
            UIView.animateKeyframes(withDuration: 2, delay: 0) {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                    self.friendsPhotoImageview.transform = .init(translationX: Constants.moveViewInXNumber, y: 0)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.3) {
                    self.friendsPhotoImageview.alpha = 1
                    self.friendsPhotoImageview.transform = .init(translationX: 0, y: 0)
                }
            }
        default:
            return
        }
    }

    private func swipeLeftAction(gesture: UIPanGestureRecognizer) {
        guard index != Constants.minImagesNumber else { return }
        switch gesture.state {
        case .began:
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.friendsPhotoImageview.transform = CGAffineTransform(
                    translationX: Constants.moveViewInXNumber,
                    y: 0
                ).concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
            }
        case .changed:
            let translation = gesture.translation(in: view)
            swipePropertyAnimator.fractionComplete = translation.x / Constants.moveViewInXNumber
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.friendsPhotoImageview.alpha = 0
            }
        case .ended:
            index -= 1
            UIView.animateKeyframes(withDuration: 2, delay: 0) {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                    self.friendsPhotoImageview.transform = .init(translationX: -Constants.moveViewInXNumber, y: 0)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.3) {
                    self.friendsPhotoImageview.alpha = 1
                    self.friendsPhotoImageview.transform = .init(translationX: 0, y: 0)
                }
            }
        default:
            return
        }
    }

    @objc private func swipeAction(gesture: UIPanGestureRecognizer) {
        if gesture.translation(in: view).x < 0 {
            swipeRightAction(gesture: gesture)
        } else {
            swipeLeftAction(gesture: gesture)
        }
        friendsPhotoImageview.image = usersPhotoImages[index]
    }

    @objc private func dismissAction(gesture: UIPanGestureRecognizer) {
        let velocity = gesture.velocity(in: view)
        let swipe = velocity.y > Constants.swipeVelocityNumber
        guard swipe else { return }
        dismiss(animated: true)
    }
}

/// Constants
extension SortedFriendsPhotosViewController {
    private enum Constants {
        static let moveViewInXNumber: CGFloat = 300
        static let swipeVelocityNumber: CGFloat = 500
        static let maxImagesNumber = 2
        static let minImagesNumber = 0
        static let getPhotosMethodName = "photos.get"
    }
}
