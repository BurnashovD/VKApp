// Post.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Posts
final class Posts: Decodable {
    /// Айтемы постов
    var items: [PostItem]?
    /// Айтемы групп
    var groups: [GroupItem]?
    /// Айтемы профилей
    var profiles: [UserItem]?
    /// Следующий пост
    var nextPost: String? = ""

    enum CodingKeys: String, CodingKey {
        case items
        case groups
        case profiles
        case nextPost = "next_from"
    }

    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([PostItem].self, forKey: .items)
        groups = try container.decode([GroupItem].self, forKey: .groups)
        profiles = try container.decode([UserItem].self, forKey: .profiles)
        nextPost = try? container.decodeIfPresent(String.self, forKey: .nextPost)
    }
}
