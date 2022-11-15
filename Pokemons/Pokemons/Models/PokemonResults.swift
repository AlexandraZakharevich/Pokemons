//
//  PokemonResults.swift
//  Pokemons
//
//  Created by Александра Захаревич on 15.11.22.
//

import Foundation
import ObjectMapper

class PokemonResults: Mappable {
    var name: String?
    var url: String?
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        name         <- map["name"]
        url          <- map["url"]
    }
}

