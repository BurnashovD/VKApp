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
            let groupsItems = try JSONDecoder().decode(GroupsResult.self, from: data).response.groups
            groups = groupsItems
            state = .finished
        } catch {
            print(error.localizedDescription)
        }
    }
}
