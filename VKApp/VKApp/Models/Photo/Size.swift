// Size.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Photos items
@objcMembers
final class Size: Object, Decodable {
    // MARK: - Public properties

    dynamic var id = 0
    dynamic var url = ""

    // MARK: - enum

    enum CodingKeys: CodingKey {
        case id
        case url
        case sizes
    }

    // MARK: - init

    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        var sizes = try container.nestedUnkeyedContainer(forKey: .sizes)
        let sizesContainer = try sizes.nestedContainer(keyedBy: CodingKeys.self)
        url = try sizesContainer.decode(String.self, forKey: .url)
    }

    // MARK: - Public methods

    override static func primaryKey() -> String? {
        "id"
    }
}
