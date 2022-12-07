// PostItems.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Post items
final class PostItem: Decodable {
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
    /// Кол-во просмотров
    var count: Int = 0
    /// Имя автора
    var name: String = ""
    /// Фото автора
    var profileImage: String = ""

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case text
        case type
        case attachments
        case ownerId = "owner_id"
        case views
        case groups
        case profiles
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

    enum ViewsKeys: String, CodingKey {
        case count
    }

    // MARK: - init

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let containerItem = try decoder.container(keyedBy: CodingKeys.self)
        let viewsContainer = try? container.nestedContainer(keyedBy: ViewsKeys.self, forKey: .views)
        var attValue = try? containerItem.nestedUnkeyedContainer(forKey: .attachments)
        let attContainer = try? attValue?.nestedContainer(keyedBy: AttachmentKeys.self)
        let photoContainer = try? attContainer?.nestedContainer(keyedBy: PhotoKeys.self, forKey: .photo)
        var sizisValue = try? photoContainer?.nestedUnkeyedContainer(forKey: .sizes)
        let sizesContainer = try? sizisValue?.nestedContainer(keyedBy: SizesKeys.self)
        ownerId = try container.decode(Int.self, forKey: .ownerId)
        text = try container.decode(String.self, forKey: .text)
        count = try viewsContainer?.decodeIfPresent(Int.self, forKey: .count) ?? 0
        type = try attContainer?.decode(String.self, forKey: .type) ?? ""
        postId = try photoContainer?.decodeIfPresent(Int.self, forKey: .postId) ?? 0
        url = try sizesContainer?.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
}
