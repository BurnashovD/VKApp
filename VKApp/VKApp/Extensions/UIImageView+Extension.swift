// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// UIImageView Extension
extension UIImageView {
    func fetchUserPhotos(_ url: String) {
        AF.request(url).response { response in
            guard let data = response.data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
