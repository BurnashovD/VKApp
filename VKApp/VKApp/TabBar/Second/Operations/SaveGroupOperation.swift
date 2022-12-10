// SaveGroupOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сохранение данных в realm
final class SaveGroupOperation: AsyncOperation {
    // MARK: - Private properties

    private let realmService = RealmService()

    // MARK: - Public methods

    override func main() {
        guard let parseGroupOperation = dependencies.first as? ParseGroupsDataOperation else { return }
        realmService.saveData(parseGroupOperation.groups)
        state = .finished
    }
}
