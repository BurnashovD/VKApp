// PostItems.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class PostItems: Decodable {
    var ownerId: Int = 0
    var text: String = ""
    var url: String = ""

    enum CodingKeys: String, CodingKey {
        case ownerId = "owner_id"
        case text
        case attachments
        case photo
    }

    enum AttachmentKeys: String, CodingKey {
        case photo
        case ownerId = "owner_id"
        case sizes
        case url
    }

    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ownerId = try container.decode(Int.self, forKey: .ownerId)
        text = try container.decode(String.self, forKey: .text)
        var attValue = try container.nestedUnkeyedContainer(forKey: .attachments)
        let attContainer = try attValue.nestedContainer(keyedBy: CodingKeys.self)
        let photoContainer = try attContainer.nestedContainer(keyedBy: AttachmentKeys.self, forKey: .photo)
        ownerId = try photoContainer.decode(Int.self, forKey: .ownerId)
        var sizesValue = try photoContainer.nestedUnkeyedContainer(forKey: .sizes)
        let sizesContainer = try sizesValue.nestedContainer(keyedBy: AttachmentKeys.self)
        url = try sizesContainer.decode(String.self, forKey: .url)
    }
}
