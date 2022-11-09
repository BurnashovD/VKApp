// PhotoView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью с фото
@IBDesignable class PhotoView: UIView {
    // MARK: - Visual components

    @IBInspectable private var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable private var shadowColor: UIColor? {
        didSet {
            layer.shadowColor = shadowColor?.cgColor
        }
    }

    @IBInspectable private var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    @IBInspectable private var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable private var shadowOffset: CGSize = .init(width: 0, height: 0) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }

    @IBInspectable private var backgroundColour: UIColor? {
        didSet {
            backgroundColor = backgroundColor
        }
    }
}
