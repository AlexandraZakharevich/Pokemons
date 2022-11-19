//
//  RealmNameModel.swift
//  Pokemons
//
//  Created by Александра Захаревич on 19.11.22.
//

import Foundation
import RealmSwift

class RealmNameModel : Object {
    @objc dynamic var  pokemonName = ""
    
    convenience init(pokemonName: String) {
        self.init()
        self.pokemonName = pokemonName
    }
}

