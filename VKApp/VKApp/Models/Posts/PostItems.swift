// PostItems.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Post items
final class PostItems: Decodable {
    /// Тип
    var type: String = ""
    /// Текст поста
    var text: String = ""
    /// id поста
    var postId: Int = 0
    /// Ссылка на фото в посте
    var url: String = ""
    /// id автора
    var ownerId: Int = 0

    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case text
        case type
        case attachments
        case ownerId = "owner_id"
    }

    enum AttachmentKeys: String, CodingKey {
        case photo
        case type
    }

    enum PhotoKeys: String, CodingKey {
        case postId = "post_id"
        case sizes
    }

    enum SizesKeys: String, CodingKey {
        case url
    }

    // MARK: - init
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let containerItem = try decoder.container(keyedBy: CodingKeys.self)
        ownerId = try container.decode(Int.self, forKey: .ownerId)
        text = try container.decode(String.self, forKey: .text)
        var attValue = try? containerItem.nestedUnkeyedContainer(forKey: .attachments)
        let attContainer = try? attValue?.nestedContainer(keyedBy: AttachmentKeys.self)
        type = try attContainer?.decode(String.self, forKey: .type) ?? ""
        let photoContainer = try? attContainer?.nestedContainer(keyedBy: PhotoKeys.self, forKey: .photo)
        postId = try photoContainer?.decodeIfPresent(Int.self, forKey: .postId) ?? 0
        var sizisValue = try? photoContainer?.nestedUnkeyedContainer(forKey: .sizes)
        let sizesContainer = try? sizisValue?.nestedContainer(keyedBy: SizesKeys.self)
        url = try sizesContainer?.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
}
