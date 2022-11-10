// SortedFriendsPhotosViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SortedFriendsPhotosViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var friendsPhotoImageview: UIImageView!

    var swipeAnimation = UIViewPropertyAnimator()

    private var usersPhotosNames: [String] = []
    private var index = 0

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        createGestures()
    }

    func getUserPhotos(photos: [String]) {
        usersPhotosNames = photos
    }

    private func setImage() {
        guard let photo = usersPhotosNames.first, let image = UIImage(named: photo) else { return }
        friendsPhotoImageview.image = image
        friendsPhotoImageview.isUserInteractionEnabled = true
    }

    private func createGestures() {
        let leftSwipeGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeLeft(gesture:)))
        friendsPhotoImageview.addGestureRecognizer(leftSwipeGesture)
    }

    @objc func swipeLeft(gesture: UIPanGestureRecognizer) {
        guard index < 2 else { return }
        let transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        switch gesture.state {
        case .began:
            swipeAnimation.startAnimation()
            swipeAnimation = UIViewPropertyAnimator(
                duration: 0.5,
                dampingRatio: 0.5,
                animations: {
                    self.friendsPhotoImageview.transform = CGAffineTransform(
                        translationX: -300,
                        y: 0
                    )
                }
            )
            swipeAnimation.pauseAnimation()
        case .changed:
            let translation = gesture.translation(in: view)
            swipeAnimation.fractionComplete = translation.x / -200
        case .ended:
            swipeAnimation.startAnimation()
            swipeAnimation.stopAnimation(true)
            swipeAnimation.addAnimations {
                self.friendsPhotoImageview.transform = .init(translationX: 300, y: 0)
            }
            swipeAnimation
            swipeAnimation.startAnimation()
        default:
            return
        }
    }
}
