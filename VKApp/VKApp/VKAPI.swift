// VKAPI.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Получение данных с ВК
final class VKAPIService {
    // MARK: - Public methods

    func fetchData(
        _ method: String,
        parametrMap: [String: String]
    ) {
        var parametrs: Parameters = [
            Constants.accessTokenText: Session.shared.token,
            Constants.vText: Constants.apiVersionText
        ]
        for param in parametrMap {
            parametrs[param.key] = param.value
        }
        let url = Constants.baseURLText + Constants.methodText + method
        AF.request(url, parameters: parametrs).responseJSON { response in
            print(response.value)
        }
    }
}

/// Constants
extension VKAPIService {
    private enum Constants {
        static let baseURLText = "https://api.vk.com/"
        static let methodText = "method/"
        static let fieldsText = "fields"
        static let accessTokenText = "access_token"
        static let vText = "v"
        static let apiVersionText = "5.131"
    }
}
