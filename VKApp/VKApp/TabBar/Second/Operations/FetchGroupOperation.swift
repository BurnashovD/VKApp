// FetchGroupOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Получение данных групп
final class FetchGroupOperation: AsyncOperation {
    // MARK: - Public properties

    var data: Data?

    // MARK: - Private properties

    private let networkService = NetworkService()

    // MARK: - Public methods

    override func main() {
        networkService.fetchGroupOperation(Constants.getGroupsMethodName) { [weak self] responseData in
            guard let self = self else { return }
            self.data = responseData
            self.state = .finished
        }
    }
}

/// Constants
extension FetchGroupOperation {
    enum Constants {
        static let getGroupsMethodName = "groups.get"
    }
}
