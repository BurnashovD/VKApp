// CustomNavigationController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомный NavigationController
final class CustomNavigationController: UINavigationController {
    // MARK: - Private properties

    private let interactiveTransition = CustomInteractiveTransition()

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
            interactiveTransition.viewController = toVC
            return CustomPushAnimation()
        case .pop:
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            return CustomPopAnimation()
        default:
            return nil
        }
    }

    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition.isStarted ? interactiveTransition : nil
    }
}
