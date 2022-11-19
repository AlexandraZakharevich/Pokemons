//
//  RealmPokemonModel.swift
//  Pokemons
//
//  Created by Александра Захаревич on 19.11.22.
//

import Foundation
import RealmSwift

class RealmPokemonModel: Object {
    @objc dynamic var  pokemonImage = ""
    @objc dynamic var  pokemonName = ""
    @objc dynamic var  pokemonWeight = 0
    @objc dynamic var  pokemonHeight = 0
    @objc dynamic var  pokemonTypes = ""
    
    convenience init(pokemonImage: String, pokemonName: String, pokemonWeight: Int, pokemonHeight: Int, pokemonTypes: String ) {
        self.init()
        self.pokemonImage = pokemonImage
        self.pokemonName = pokemonName
        self.pokemonWeight = pokemonWeight
        self.pokemonHeight = pokemonHeight
        self.pokemonTypes = pokemonTypes
    }
}
