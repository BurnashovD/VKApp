// VKAPI.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import RealmSwift

/// Получение данных с ВК
final class NetworkService {
    // MARK: - Public properties

    let userGroupParametrsNames = [
        Constants.userIdParametrName: String(Session.shared.userId),
        Constants.extendedParametrName: Constants.extendedParametrValue
    ]
    let fetchFriendsParametrName = [
        Constants.fieldsParametrName: Constants.getPhotoParametrName,
        Constants.orderParametrName: Constants.nameParametrName
    ]

    // MARK: - Public methods

    func fetchUsers(
        _ method: String,
        parametrMap: [String: String],
        _ complition: @escaping ([Item]) -> Void
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
                let usersResults = try? JSONDecoder().decode(UsersResult.self, from: data)
                guard let items = usersResults?.response.items else { return }
                complition(items)
                self.saveUsersData(items)
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
        var parametrs: Parameters = [
            Constants.accessTokenText: Session.shared.token,
            Constants.vText: Constants.apiVersionText,
            Constants.ownerIdParametrName: userId,
            Constants.albumIdParametrName: Constants.profileParametrName
        ]
        let url = "\(Constants.baseURLText)\(Constants.methodText)\(method)"
        AF.request(url, parameters: parametrs).responseJSON { response in
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
                self.savePhotosData(items)
            } catch {
                print(response.error)
            }
        }
    }

    func fetchGroup(
        _ method: String,
        parametrMap: [String: String],
        _ complition: @escaping ([Groups]) -> Void
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
                let items = usersResults.response.items
                complition(items)
                self.saveGroupsData(items)
            } catch {
                print(response.error)
            }
        }
    }

    func fetchProfilePhotos(_ url: String, _ complition: @escaping (UIImage) -> Void) {
        AF.request(url).response { response in
            guard let image = response.data, let safeImage = UIImage(data: image) else { return }
            complition(safeImage)
        }
    }

    func fetchSortedUsersPhotos(_ url: String, _ complition: @escaping (UIImage) -> Void) {
        AF.request(url).response { response in
            guard let result = response.data, let userPhoto = UIImage(data: result) else { return }
            complition(userPhoto)
        }
    }

    private func saveUsersData(_ user: [Item]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(user)
            }
        } catch {
            print(error)
        }
    }

    private func savePhotosData(_ photo: [Size]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(photo)
            }
        } catch {
            print(error)
        }
    }

    private func saveGroupsData(_ group: [Groups]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(group)
            }
        } catch {
            print(error)
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
        static let userIdParametrName = "user_id"
        static let extendedParametrName = "extended"
        static let extendedParametrValue = "1"
        static let fieldsParametrName = "fields"
        static let idParametrName = "id"
        static let orderParametrName = "order"
        static let nameParametrName = "name"
        static let getPhotoParametrName = "photo_100"
        static let ownerIdParametrName = "owner_id"
        static let albumIdParametrName = "album_id"
        static let profileParametrName = "profile"
    }
}
