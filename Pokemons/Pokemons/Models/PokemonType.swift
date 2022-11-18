//
//  PokemonType.swift
//  Pokemons
//
//  Created by Александра Захаревич on 18.11.22.
//

import Foundation
import ObjectMapper

class PokemonType: Mappable {
    var name: String?
    var url: String?
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        name      <- map["name"]
        url       <- map["url"]
    }
}
