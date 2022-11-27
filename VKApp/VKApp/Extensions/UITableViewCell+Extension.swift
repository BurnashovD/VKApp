// UITableViewCell+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

extension UITableViewCell {
    func fetchGlobalGroupsPhotos(_ photo: String, _ complition: @escaping (UIImage) -> Void) {
        AF.request(photo).response { response in
            guard let image = response.data, let safeImage = UIImage(data: image) else { return }
            complition(safeImage)
        }
    }
}
