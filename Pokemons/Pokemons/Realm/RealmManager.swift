//
//  RealmManager.swift
//  Pokemons
//
//  Created by Александра Захаревич on 19.11.22.
//

import Foundation
import RealmSwift

class RealmManager {
    private let realm = try! Realm()
    
    static let shared = RealmManager()
    
    private init(){}
    
    func readPokemons() -> [RealmPokemonModel] {
        let result = realm.objects(RealmPokemonModel.self)
        return Array(result)
    }
    
    func savePokemons(object: RealmPokemonModel) {
         try? realm.write {
             realm.add(object)
        }
    }
    
    func readNames() -> [RealmNameModel] {
        let result = realm.objects(RealmNameModel.self)
        return Array(result)
    }
    
    func saveNames(object: RealmNameModel) {
         try? realm.write {
             realm.add(object)
        }
    }
}
