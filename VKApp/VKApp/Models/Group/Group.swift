// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Group
struct Group {
    let name: String
    let groupImageName: String
}

final class GroupsResult: Codable {
    var response: GroupResponse
}
