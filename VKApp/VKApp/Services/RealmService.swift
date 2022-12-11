// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Сохранение данных Realm
struct RealmService {
    // MARK: - Private properties

    private var notificationToken: NotificationToken?

    // MARK: - Public methods

    func saveData<T>(_ model: [T]) where T: Object {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            realm.add(model, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadData<T>(_ model: T.Type, _ completion: @escaping (Results<T>) -> Void) where T: Object {
        do {
            let realm = try Realm()
            let objects = realm.objects(model)
            completion(objects)
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteRowAction<T>(_ model: T) where T: Object {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            realm.delete(model)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
}
