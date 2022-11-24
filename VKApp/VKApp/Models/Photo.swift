// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

struct PhotoResult: Decodable {
    var response: Photos
}

struct Photos: Decodable {
    var items: [Size]
}

struct Size: Decodable {
    var url: String

    enum CodingKeys: CodingKey {
        case url
        case sizes
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var sizes = try container.nestedUnkeyedContainer(forKey: .sizes)
        let sizesContainer = try sizes.nestedContainer(keyedBy: CodingKeys.self)
        url = try sizesContainer.decode(String.self, forKey: .url)
    }
}
