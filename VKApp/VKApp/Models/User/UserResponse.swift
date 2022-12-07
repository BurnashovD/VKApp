// UserResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Server response
final class Response: Decodable {
    /// Количество
    var count: Int
    /// Айтемы юзера
    var items: [UserItem]
}
