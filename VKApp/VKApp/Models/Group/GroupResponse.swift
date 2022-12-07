// GroupResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Server response
final class GroupResponse: Codable {
    /// Айтемы групп
    var groups: [GroupItem]

    enum CodingKeys: String, CodingKey {
        case groups = "items"
    }
}
