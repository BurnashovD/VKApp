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
            realm.beginWrite()
            realm.add(model, update: .all)
            try realm.commitWrite()
            print(realm.configuration.fileURL)
        } catch {
            print(error)
        }
    }

    func getData(_ model: Object.Type) {
        do {
            let realm = try Realm()
            let objects = realm.objects(model.self)
            var result = Array(objects)
        } catch {
            print(error)
        }
    }
}
