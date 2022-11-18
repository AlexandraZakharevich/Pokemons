//
//  Types.swift
//  Pokemons
//
//  Created by Александра Захаревич on 17.11.22.
//

import Foundation
import ObjectMapper

class Types: Mappable {
    var slot: Int?
    var type: PokemonType?
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        slot        <- map["slot"]
        type        <- map["type"]
    }
}
