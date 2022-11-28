// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// UIImageView Extension
extension UIImageView {
    func fetchUserPhotos(_ url: String) {
        let networkService = NetworkService()
        networkService.fetchUserPhotos(url) { image in
            self.image = image
        }
    }
}
