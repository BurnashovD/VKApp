// SessionSingleton.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Синглтон с данными о сессии
final class Session {
    // MARK: - Public properties

    var token = ""
    var userId = 0

    static let shared = Session()

    // MARK: - init

    private init() {}
}
