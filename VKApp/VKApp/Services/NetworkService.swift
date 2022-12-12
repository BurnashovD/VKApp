// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import PromiseKit

/// Получение данных с ВК
final class NetworkService {
    // MARK: - Private properties

    private let realmService = RealmService()

    // MARK: - Public properties

    let userGroupParametrsNames = [
        Constants.userIdParameterName: String(Session.shared.userId),
        Constants.extendedParameterName: Constants.extendedParameterValue
    ]
    let fetchFriendsParametrName = [
        Constants.fieldsParameterName: Constants.getPhotoParameterName,
        Constants.orderParameterName: Constants.nameParameterName
    ]

    // MARK: - Public methods

    func fetchUsers(
        _ method: String,
        parametrMap: [String: String],
        _ complition: @escaping ([UserItem]) -> Void
    ) {
        var parameters: Parameters = [
            Constants.accessTokenText: Session.shared.token,
            Constants.vText: Constants.apiVersionText
        ]
        for param in parametrMap {
            parameters[param.key] = param.value
        }
        let url = "\(Constants.baseURLText)\(Constants.methodText)\(method)"
        AF.request(url, parameters: parameters).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let usersResults = try? JSONDecoder().decode(UsersResult.self, from: data)
                guard let items = usersResults?.response.userItems else { return }
                complition(items)
                self.realmService.saveData(items)
            } catch {
                print(response.error)
            }
        }
    }

    func fetchPhotos(
        _ method: String,
        _ userId: String,
        _ complition: @escaping ([String]) -> Void
    ) {
        var parameters: Parameters = [
            Constants.accessTokenText: Session.shared.token,
            Constants.vText: Constants.apiVersionText,
            Constants.ownerIdParameterName: userId,
            Constants.albumIdParameterName: Constants.profileParameterName
        ]
        let url = "\(Constants.baseURLText)\(Constants.methodText)\(method)"
        AF.request(url, parameters: parameters).responseJSON { response in
            guard let data = response.data else { return }
            do {
                guard let usersResults = try? JSONDecoder().decode(PhotoResult.self, from: data).response.items
                else { return }
                let items = usersResults
                var photosURLs = [String]()
                items.forEach { item in
                    photosURLs.append(item.url)
                }
                complition(photosURLs)
                self.realmService.saveData(items)
            } catch {
                print(response.error)
            }
        }
    }

    func fetchGroup(
        _ method: String,
        parametrMap: [String: String],
        _ complition: @escaping ([GroupItem]) -> Void
    ) {
        var parametrs: Parameters = [
            Constants.accessTokenText: Session.shared.token,
            Constants.vText: Constants.apiVersionText
        ]
        for param in parametrMap {
            parametrs[param.key] = param.value
        }
        let url = "\(Constants.baseURLText)\(Constants.methodText)\(method)"
        AF.request(url, parameters: parametrs).responseJSON { response in
            guard let data = response.data else { return }
            do {
                guard let usersResults = try? JSONDecoder().decode(GroupsResult.self, from: data) else { return }
                let items = usersResults.response.groups
                complition(items)
                self.realmService.saveData(items)
            } catch {
                print(response.error)
            }
        }
    }

    func fetchGroupOperation(_ method: String, _ completion: @escaping (Data) -> Void) {
        var parameters: Parameters = [
            Constants.accessTokenText: Session.shared.token,
            Constants.vText: Constants.apiVersionText,
            Constants.userIdParameterName: String(Session.shared.userId),
            Constants.extendedParameterName: Constants.extendedParameterValue
        ]
        let url = "\(Constants.baseURLText)\(Constants.methodText)\(method)"
        AF.request(url, parameters: parameters).responseJSON { response in
            guard let data = response.data else { return }
            completion(data)
        }
    }

    func fetchPosts(
        _ method: String,
        _ completion: @escaping (Posts) -> Void
    ) {
        var parameters: Parameters = [
            Constants.accessTokenText: Session.shared.token,
            Constants.filtersParameterName: Constants.filtersParameterValue,
            Constants.vText: Constants.apiVersionText
        ]
        let url = "\(Constants.baseURLText)\(Constants.methodText)\(method)"
        DispatchQueue.global().async {
            AF.request(url, parameters: parameters).responseJSON { response in
                guard let data = response.data else { return }
                do {
                    guard let postsResults = try? JSONDecoder().decode(PostResponse.self, from: data).response
                    else { return }
                    DispatchQueue.main.async {
                        completion(postsResults)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func fetchPostsProfiles(
        _ method: String,
        _ completion: @escaping (Posts) -> Void
    ) {
        var parameters: Parameters = [
            Constants.accessTokenText: Session.shared.token,
            Constants.filtersParameterName: Constants.filtersParameterValue,
            Constants.vText: Constants.apiVersionText
        ]
        let url = "\(Constants.baseURLText)\(Constants.methodText)\(method)"
        DispatchQueue.global().async {
            AF.request(url, parameters: parameters).responseJSON { response in
                guard let data = response.data else { return }
                do {
                    guard let postsResults = try? JSONDecoder().decode(PostResponse.self, from: data).response
                    else { return }

                    DispatchQueue.main.async {
                        completion(postsResults)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func fetchPostsGroups(
        _ method: String,
        _ completion: @escaping ([GroupItem]) -> Void
    ) {
        var parameters: Parameters = [
            Constants.accessTokenText: Session.shared.token,
            Constants.filtersParameterName: Constants.filtersParameterValue,
            Constants.vText: Constants.apiVersionText
        ]
        let url = "\(Constants.baseURLText)\(Constants.methodText)\(method)"
        DispatchQueue.global().async {
            AF.request(url, parameters: parameters).responseJSON { response in
                guard let data = response.data else { return }
                do {
                    guard let postsResults = try? JSONDecoder().decode(PostResponse.self, from: data).response.groups
                    else { return }

                    DispatchQueue.main.async {
                        completion(postsResults)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func fetchSearchGroup(
        _ method: String,
        _ searchText: String,
        _ complition: @escaping ([GroupItem]) -> Void
    ) {
        var parameters: Parameters = [
            Constants.accessTokenText: Session.shared.token,
            Constants.vText: Constants.apiVersionText,
            Constants.qParameterName: searchText,
            Constants.typeparameterName: Constants.groupTypeName
        ]
        let url = "\(Constants.baseURLText)\(Constants.methodText)\(method)"
        AF.request(url, parameters: parameters).responseJSON { response in
            guard let data = response.data else { return }
            do {
                guard let usersResults = try? JSONDecoder().decode(GroupsResult.self, from: data) else { return }
                let items = usersResults.response.groups
                complition(items)
                self.realmService.saveData(items)
            } catch {
                print(response.error)
            }
        }
    }

    func fetchUserPhotos(_ url: String, _ completion: @escaping (Data?) -> Void) {
        AF.request(url).response { response in
            guard let data = response.data else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}

/// Constants
extension NetworkService {
    private enum Constants {
        static let baseURLText = "https://api.vk.com/"
        static let methodText = "method/"
        static let fieldsText = "fields"
        static let accessTokenText = "access_token"
        static let vText = "v"
        static let apiVersionText = "5.131"
        static let qParameterName = "q"
        static let typeparameterName = "type"
        static let groupTypeName = "group"
        static let userIdParameterName = "user_id"
        static let extendedParameterName = "extended"
        static let extendedParameterValue = "1"
        static let fieldsParameterName = "fields"
        static let idParametrName = "id"
        static let orderParameterName = "order"
        static let nameParameterName = "name"
        static let getPhotoParameterName = "photo_100"
        static let ownerIdParameterName = "owner_id"
        static let albumIdParameterName = "album_id"
        static let profileParameterName = "profile"
        static let filtersParameterName = "filters"
        static let filtersParameterValue = "post"
    }
}
