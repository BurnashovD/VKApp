// ParseGroupsDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Парсинг данных групп
final class ParseGroupsDataOperation: AsyncOperation {
    // MARK: - Public properties

    var groups: [GroupItem] = []

    // MARK: - Public methods

    override func main() {
        guard let fetchGroupOperation = dependencies.first as? FetchGroupOperation,
              let data = fetchGroupOperation.data else { return }

        do {
            guard let groupsItems = try? JSONDecoder().decode(PostResponse.self, from: data).response.groups
            else { return }
            groups = groupsItems
            state = .finished
        } catch {
            print(error.localizedDescription)
        }
    }
}
