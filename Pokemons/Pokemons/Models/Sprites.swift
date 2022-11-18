//
//  Sprites.swift
//  Pokemons
//
//  Created by Александра Захаревич on 18.11.22.
//

import Foundation
import ObjectMapper

class Sprites: Mappable {
    var front_default: String?
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        front_default         <- map["front_default"]
    }
}
