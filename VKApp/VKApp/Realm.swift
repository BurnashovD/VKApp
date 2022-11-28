// Realm.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Сохранение данных Realm
struct RealmService {
    // MARK: - Public methods

    func saveData<T>(_ model: [T]) where T: Object {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(model)
            }
        } catch {
            print(error)
        }
    }
}
