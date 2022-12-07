// UserItem.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// User items
@objcMembers
final class UserItem: Object, Decodable {
    // MARK: - Public properties

    /// Имя
    dynamic var firstName = ""
    /// Фамилия
    dynamic var lastName = ""
    /// Ссылка на фото
    dynamic var photo = ""
    /// id
    dynamic var userId = 0

    // MARK: - enum

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userId = "id"
        case photo = "photo_100"
    }

    // MARK: - init

    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        userId = try container.decode(Int.self, forKey: .userId)
        photo = try container.decode(String.self, forKey: .photo)
    }

    // MARK: - Public methods

    override static func primaryKey() -> String? {
        "userId"
    }
}
