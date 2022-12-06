// PostSize.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class PostSize: Decodable {
    var url: String = ""

    enum CodingKeys: String, CodingKey {
        case url
    }

    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
    }
}
