//
//  RealmManager.swift
//  Pokemons
//
//  Created by Александра Захаревич on 19.11.22.
//

import Foundation
import RealmSwift

class RealmManager {
    private static let realm = try! Realm()
    
//    static func startTransation() {
//        realm.beginWrite()
//    }
//
//    static func closeTransaction() {
//         try? realm.commitWrite()
//    }
//
//    class func read<T: Object>(type: T.Type) -> [T] {
//        return Array(realm.objects(type.self))
//    }
//
//    class func write<T: Object>(object: T) {
//        try? realm.write({
//            realm.add(object)
//        })
//    }
    
    static func read() -> [RealmPokemonModel] {
        let result = realm.objects(RealmPokemonModel.self)
        return Array(result)
    }
    
    static func save(object: RealmPokemonModel) {
         try? realm.write {
             realm.add(object)
        }
    }
}
