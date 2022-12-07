// Items.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Groups items
@objcMembers
final class GroupItem: Object, Codable {
    // MARK: - Public properties
    
    /// id
    dynamic var id = 0
    /// Имя
    dynamic var name = ""
    /// Ссылка на фото
    dynamic var photo = ""

    // MARK: - enum

    enum CodingKeys: String, CodingKey {
        case id, name
        case photo = "photo_100"
    }

    // MARK: - init

    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        photo = try container.decode(String.self, forKey: .photo)
        id = try container.decode(Int.self, forKey: .id)
    }

    // MARK: - Public methods

    override static func primaryKey() -> String? {
        "id"
    }
}
