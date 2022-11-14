// CustomPopAnimation.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомный pop
final class CustomPopAnimation: NSObject {
    // MARK: - Private methods

    private func popAnimation(
        transitionContext: UIViewControllerContextTransitioning,
        source: UIViewController,
        destination: UIViewController
    ) {
        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 0.75
                ) {
                    let translation = CGAffineTransform(translationX: 0, y: 0)
                    let scale = CGAffineTransform(scaleX: 1, y: 1)
                    source.view.transform = translation.concatenating(scale)
                }

                UIView.addKeyframe(
                    withRelativeStartTime: 0.2,
                    relativeDuration: 0.4
                ) {
                    let translation = CGAffineTransform(
                        translationX: Constants.moveViewInXNumber,
                        y: source.view.frame.width * Constants.moveViewInYNumber
                    )
                    let scale = CGAffineTransform(rotationAngle: .pi / Constants.rightAngleNumber)
                    source.view.transform = translation.concatenating(scale)
                }

                UIView.addKeyframe(
                    withRelativeStartTime: 0.6,
                    relativeDuration: 0.4
                ) {
                    destination.view.transform = .identity
                }
            }, completion: { finished in
                if finished, !(transitionContext.transitionWasCancelled) {
                    source.removeFromParent()
                    destination.view.transform = .identity
                    transitionContext.completeTransition(true)
                }
                transitionContext.completeTransition(finished && !(transitionContext.transitionWasCancelled))
            }
        )
    }
}

/// Constants
extension CustomPopAnimation {
    enum Constants {
        static let rightAngleNumber: CGFloat = -2
        static let moveViewInXNumber: CGFloat = 200
        static let moveViewInYNumber: CGFloat = 1.5
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension CustomPopAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.7
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.insertSubview(destination.view, at: 0)
        destination.view.frame = source.view.frame

        let translate = CGAffineTransform(
            translationX: source.view.frame.width / 50,
            y: 0
        )
        let rotate = CGAffineTransform(scaleX: 0.8, y: 0.8)
        destination.view.transform = translate.concatenating(rotate)
        popAnimation(transitionContext: transitionContext, source: source, destination: destination)
    }
}
