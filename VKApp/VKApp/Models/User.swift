// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// User
final class UsersResult: Decodable {
    var response: Response
}

final class Response: Decodable {
    var count: Int
    var items: [Item]
}

final class Item: Object, Decodable {
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var photo = ""
    @objc dynamic var userId = 0

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userId = "id"
        case photo = "photo_100"
    }

    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        userId = try container.decode(Int.self, forKey: .userId)
        photo = try container.decode(String.self, forKey: .photo)
    }
}
