// UserResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Server response
final class UserResponse: Decodable {
    /// Количество
    var count: Int
    /// Айтемы юзера
    var userItems: [UserItem]

    enum CodingKeys: String, CodingKey {
        case count
        case userItems = "items"
    }
}
