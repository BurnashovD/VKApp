// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Group
struct Group {
    let name: String
    let groupImageName: String
}

final class GroupsResult: Codable {
    var response: GroupResponse
}
