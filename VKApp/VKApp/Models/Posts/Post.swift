// Post.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Posts
final class Posts: Decodable {
    var items: [PostItem]?
    var groups: [GroupItem]?
    var profiles: [UserItem]?

    enum CodingKeys: String, CodingKey {
        case items
        case groups
        case profiles
    }

    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([PostItem].self, forKey: .items)
        groups = try container.decode([GroupItem].self, forKey: .groups)
        profiles = try container.decode([UserItem].self, forKey: .profiles)
    }
}
