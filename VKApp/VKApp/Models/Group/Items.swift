// Items.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Groups items
final class Groups: Object, Codable {
    @objc dynamic var name = ""
    @objc dynamic var photo = ""

    enum CodingKeys: String, CodingKey {
        case name
        case photo = "photo_100"
    }

    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        photo = try container.decode(String.self, forKey: .photo)
    }
}
