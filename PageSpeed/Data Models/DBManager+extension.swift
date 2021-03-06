//
//  DBManager+extention.swift
//  PageSpeed
//
//  Created by Ilya on 19.03.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import RealmSwift

extension DBManager {
    @discardableResult
    func save (object: Object) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object)
            }
            return true
        } catch {
            print("Realm write error: \(error)")
            return false
        }
    }

    func getItems<T: Object>() -> Results<T>? {
        do {
            let realm = try Realm()
            let results: Results<T> = realm.objects(T.self)
            return results
        } catch {}
        return nil
    }

    func deleleHistory() {
        do {

            let realm = try Realm()
            let gtMetrixItems = realm.objects(GTMetrixResponseItem.self)
            let pageSpeedV5Items = realm.objects(PageSpeedV5Item.self)
            try realm.write {
                realm.delete(gtMetrixItems)
                realm.delete(pageSpeedV5Items)
            }
        } catch {}
    }
}
