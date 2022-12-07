// PhotoResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Server response
final class Photos: Decodable {
    /// Айтемы фотографий
    var items: [Size]
}
