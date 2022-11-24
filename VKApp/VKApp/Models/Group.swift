// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Group
struct Group {
    let name: String
    let groupImageName: String
}

struct GroupsResult: Codable {
    var response: GroupResponse
}

struct GroupResponse: Codable {
    var items: [Groups]
}

struct Groups: Codable {
    var name: String
    var photo: String

    enum CodingKeys: String, CodingKey {
        case name
        case photo = "photo_100"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        photo = try container.decode(String.self, forKey: .photo)
    }
}
