// CustomInteractiveTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерактивное закрытие
final class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Visual components

    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgeAction))
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }

    // MARK: - Public properties

    var isStarted = false

    // MARK: - Private properties

    private var shouldFinish = false

    // MARK: - Private methods

    @objc private func handleScreenEdgeAction(_ recogniser: UIScreenEdgePanGestureRecognizer) {
        switch recogniser.state {
        case .began:
            isStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            guard let recWidth = recogniser.view?.bounds.width else { return }
            let translation = recogniser.translation(in: recogniser.view)
            let relativeTranslation = translation.y / recWidth
            let progress = max(0, min(1, relativeTranslation))
            shouldFinish = progress > 0.33
            update(progress)
        case .ended:
            isStarted = false
            shouldFinish ? finish() : cancel()
        case .cancelled:
            isStarted = false
            cancel()
        default:
            break
        }
    }
}
