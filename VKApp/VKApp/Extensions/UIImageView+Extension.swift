// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import RealmSwift
import UIKit

/// UIImageView Extension
extension UIImageView {
    func fetchUserPhotos(_ url: String, networkService: NetworkService) {
        networkService.fetchUserPhotos(url) { [weak self] data in
            guard let self = self, let data = data, let safeImage = UIImage(data: data) else { return }
            self.image = safeImage
        }
    }
}
