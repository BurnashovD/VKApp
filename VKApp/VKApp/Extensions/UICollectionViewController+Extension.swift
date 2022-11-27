// UICollectionViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

extension UICollectionViewController {
    func fetchUserPhotos(_ url: String, _ complition: @escaping (UIImage) -> Void) {
        AF.request(url).response { response in
            guard let data = response.data, let image = UIImage(data: data) else { return }
            complition(image)
        }
    }
}
