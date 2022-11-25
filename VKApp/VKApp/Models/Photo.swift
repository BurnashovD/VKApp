// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Photo
final class PhotoResult: Decodable {
    var response: Photos
}

final class Photos: Decodable {
    var items: [Size]
}

final class Size: Object, Decodable {
    @objc dynamic var url = ""

    enum CodingKeys: CodingKey {
        case url
        case sizes
    }

    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var sizes = try container.nestedUnkeyedContainer(forKey: .sizes)
        let sizesContainer = try sizes.nestedContainer(keyedBy: CodingKeys.self)
        url = try sizesContainer.decode(String.self, forKey: .url)
    }
}
