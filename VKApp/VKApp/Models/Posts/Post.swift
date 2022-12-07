// Post.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Posts
final class Posts: Decodable {
    var items: [PostItems]?
    var group: [Groups]?
    var profile: [Item]?

    enum CodingKeys: String, CodingKey {
        case items
        case group = "groups"
        case profile = "profiles"
    }

    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([PostItems].self, forKey: .items)
        group = try container.decode([Groups].self, forKey: .group)
        profile = try container.decode([Item].self, forKey: .profile)
    }
}
