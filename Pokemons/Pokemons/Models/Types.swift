//
//  Types.swift
//  Pokemons
//
//  Created by Александра Захаревич on 17.11.22.
//

import Foundation
import ObjectMapper

class Types: Mappable {
    var types: PokemonType?
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        types        <- map["types"]
    }
}

class PokemonType: Mappable {
    var nameType: String?
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        nameType        <- map["name"]
    }
}
