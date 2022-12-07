// UserResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Server response
final class Response: Decodable {
    var count: Int
    var items: [UserItem]
}
