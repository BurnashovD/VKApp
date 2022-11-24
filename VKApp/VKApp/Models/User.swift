// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// User
struct UsersResult: Decodable {
    var response: Response
}

struct Response: Decodable {
    var count: Int
    var items: [Item]
}

struct Item: Decodable {
    var firstName, lastName, photo: String
    var userId: Int

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userId = "id"
        case photo = "photo_100"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        userId = try container.decode(Int.self, forKey: .userId)
        photo = try container.decode(String.self, forKey: .photo)
    }
}
