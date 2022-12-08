// ParseGroupsDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Парсинг данных групп
final class ParseGroupsDataOperation: AsyncOperation {
    // MARK: - Public properties

    var outputGroupItems: [GroupItem] = []

    // MARK: - Private properties

    private let networkService = NetworkService()

    // MARK: - Public methods

    override func main() {
        guard let fetchGroupOperation = dependencies.first as? FetchGroupOperation,
              let data = fetchGroupOperation.data else { return }
        networkService.parseGroupData(data) { [weak self] groups in
            guard let self = self else { return }
            self.outputGroupItems = groups
            self.state = .finished
        }
    }
}
