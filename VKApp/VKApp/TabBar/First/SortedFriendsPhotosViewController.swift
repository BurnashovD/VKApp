// SortedFriendsPhotosViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SortedFriendsPhotosViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var friendsPhotoImageview: UIImageView!

    // MARK: - Private properties

    private let swipeAnimation = UIViewPropertyAnimator()

    private var usersPhotosNames: [String] = []
    private var index = 0

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        createGestures()
    }

    // MARK: - Public methods

    func getUserPhotos(photos: [String]) {
        usersPhotosNames = photos
    }

    // MARK: - Private methods

    private func setImage() {
        guard let photo = usersPhotosNames.first, let image = UIImage(named: photo) else { return }
        friendsPhotoImageview.image = image
        friendsPhotoImageview.isUserInteractionEnabled = true
    }

    private func createGestures() {
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeAction(gesture:)))
        friendsPhotoImageview.addGestureRecognizer(swipeGesture)

        let dismissGesture = UIPanGestureRecognizer(target: self, action: #selector(dismissAction))
        view.addGestureRecognizer(dismissGesture)
    }

    private func swipeRight(gesture: UIPanGestureRecognizer) {
        guard index != 2 else { return }
        switch gesture.state {
        case .began:
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.friendsPhotoImageview.transform = CGAffineTransform(
                    translationX: -300,
                    y: 0
                )
            }
        case .changed:
            let translation = gesture.translation(in: view)
            swipeAnimation.fractionComplete = translation.x / -300
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.friendsPhotoImageview.alpha = 0
            }
        case .ended:
            index += 1
            UIView.animateKeyframes(withDuration: 2, delay: 0) {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    self.friendsPhotoImageview.transform = .init(translationX: 300, y: 0)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.12, relativeDuration: 0.3) {
                    self.friendsPhotoImageview.alpha = 1
                    self.friendsPhotoImageview.transform = .init(translationX: 0, y: 0)
                }
            }
        default:
            return
        }
    }

    private func swipeLeft(gesture: UIPanGestureRecognizer) {
        guard index != 0 else { return }
        switch gesture.state {
        case .began:
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.friendsPhotoImageview.transform = CGAffineTransform(
                    translationX: 300,
                    y: 0
                )
            }
        case .changed:
            let translation = gesture.translation(in: view)
            swipeAnimation.fractionComplete = translation.x / 300
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.friendsPhotoImageview.alpha = 0
            }
        case .ended:
            index -= 1
            UIView.animateKeyframes(withDuration: 2, delay: 0) {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    self.friendsPhotoImageview.transform = .init(translationX: -300, y: 0)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.12, relativeDuration: 0.3) {
                    self.friendsPhotoImageview.alpha = 1
                    self.friendsPhotoImageview.transform = .init(translationX: 0, y: 0)
                }
            }
        default:
            return
        }
    }

    @objc func swipeAction(gesture: UIPanGestureRecognizer) {
        if gesture.translation(in: view).x < 0 {
            swipeRight(gesture: gesture)
        } else {
            swipeLeft(gesture: gesture)
        }
        friendsPhotoImageview.image = UIImage(named: usersPhotosNames[index])
    }

    @objc private func dismissAction(gesture: UIPanGestureRecognizer) {
        let velocity = gesture.velocity(in: view)
        let swipe = velocity.y > 500
        guard swipe else { return }
        dismiss(animated: true)
    }
}
