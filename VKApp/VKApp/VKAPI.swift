// VKAPI.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Получение данных с ВК
final class VKAPIService {
    // MARK: - Public methods

    func getData(
        _ method: String,
        parametrName: String,
        parametr: String,
        secondParametrName: String,
        secondParametr: String
    ) {
        let parametrs: Parameters = [
            parametrName: parametr,
            Constants.accessTokenText: Session.shared.token,
            Constants.vText: Constants.apiVersionText,
            secondParametrName: secondParametr
        ]
        let url = Constants.baseURLText + Constants.methodText + method
        AF.request(url, parameters: parametrs).responseJSON { response in
            print(response.value)
        }
    }
}

/// Constants
extension VKAPIService {
    enum Constants {
        static let baseURLText = "https://api.vk.com/"
        static let methodText = "method/"
        static let fieldsText = "fields"
        static let accessTokenText = "access_token"
        static let vText = "v"
        static let apiVersionText = "5.131"
    }
}
