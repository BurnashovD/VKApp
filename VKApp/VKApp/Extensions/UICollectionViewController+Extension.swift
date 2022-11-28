// UICollectionViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

extension UICollectionViewController {
    func fetchUserPhotos(_ url: String, _ complition: @escaping (UIImage) -> Void) {
        let networkService = NetworkService()
        networkService.fetchUserPhotos(url) { image in
            complition(image)
        }
    }
}
