//
//  PokemonDetails.swift
//  Pokemons
//
//  Created by Александра Захаревич on 16.11.22.
//

import Foundation
import ObjectMapper

class PokemonDetails: Mappable {
    var name: String?
    var weight: Int?
    var height: Int?
    var sprites: Sprites?
    var types = [Types]()
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        name                  <- map["name"]
        weight                <- map["weight"]
        height                <- map["height"]
        types                 <- map["types"]
        sprites               <- map["sprites"]
    }
}
