// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Group
struct Group {
    /// Имя
    let name: String
    /// Ссылка на фото
    let groupImageName: String
}

final class GroupsResult: Codable {
    var response: GroupResponse
}
