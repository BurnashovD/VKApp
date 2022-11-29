// Realm.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Сохранение данных Realm
struct RealmService {
    // MARK: - Public methods

    func saveData<T>(_ model: [T]) where T: Object {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            realm.add(model, update: .all)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func getData<T>(_ model: T.Type, _ completion: @escaping ([T]) -> Void) where T: Object {
        do {
            let realm = try Realm()
            let objects = realm.objects(model)
            let result = Array(objects)
            completion(result)
        } catch {
            print(error)
        }
    }
}
