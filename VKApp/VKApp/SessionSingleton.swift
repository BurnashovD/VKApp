// SessionSingleton.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Синглтон с данными о сессии
final class Session {
    // MARK: - Public properties

    static let shared = Session()

    var token = ""
    var userId = 0

    // MARK: - init

    private init() {}
}
