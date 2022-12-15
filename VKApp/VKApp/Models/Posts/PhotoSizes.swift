// PhotoSizes.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные фото
struct PhotoSizes: Decodable {
    // MARK: - Public properties
    
    /// Тип фото
    var type: String = ""
    /// Ссылка на фото
    var url: String = ""

    // MARK: - CodingKeys
    enum CodingKeys: CodingKey {
        case type
        case url
    }

    // MARK: - init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        url = try container.decode(String.self, forKey: .url)
    }
}
