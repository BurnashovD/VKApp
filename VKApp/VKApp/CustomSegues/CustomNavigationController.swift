// CustomNavigationController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомный NavigationController
final class CustomNavigationController: UINavigationController {
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

// MARK: - UINavigationControllerDelegate

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return CustomPushAnimation()
        case .pop:
            return CustomPopAnimation()
        default:
            return nil
        }
    }
}
