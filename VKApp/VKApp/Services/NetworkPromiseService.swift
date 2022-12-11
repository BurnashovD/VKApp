// NetworkPromiseService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import PromiseKit

/// Сетевой слой Promise
final class NetworkPromiseService {
    // MARK: - Public methods

    func fetchUsersPromise(_ method: String) -> Promise<[UserItem]> {
        var parameters: Parameters = [
            Constants.accessTokenText: Session.shared.token,
            Constants.vText: Constants.apiVersionText,
            Constants.fieldsParameterName: Constants.getPhotoParameterName,
            Constants.orderParameterName: Constants.nameParameterName
        ]
        let url = "\(Constants.baseURLText)\(Constants.methodText)\(method)"
        return Promise<[UserItem]> { item in
            AF.request(url, parameters: parameters).responseJSON { response in
                guard let data = response.data else { return }
                do {
                    guard let userItems = try? JSONDecoder().decode(UsersResult.self, from: data).response.userItems
                    else { return }
                    return item.fulfill(userItems)
                }
            }
        }
    }
}

/// Constants
extension NetworkPromiseService {
    enum Constants {
        static let accessTokenText = "access_token"
        static let vText = "v"
        static let apiVersionText = "5.131"
        static let fieldsParameterName = "fields"
        static let getPhotoParameterName = "photo_100"
        static let orderParameterName = "order"
        static let nameParameterName = "name"
        static let baseURLText = "https://api.vk.com/"
        static let methodText = "method/"
    }
}
