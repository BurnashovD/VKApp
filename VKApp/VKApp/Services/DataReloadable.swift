// DataReloadable.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Перезагрузка ячеек
protocol DataReloadable {
    func reloadRow(at indexPath: IndexPath)
}
