//
//  BackendAPI.swift
//  Pokemons
//
//  Created by Александра Захаревич on 15.11.22.
//

import Foundation
import Moya

enum BackendAPI {
    case getPokemonName
    case getPokemonDetails(id: Int)
}

extension BackendAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://pokeapi.co")!
    }
    
    var path: String {
        switch self {
        case .getPokemonName:
            return "/api/v2/pokemon"
        case .getPokemonDetails(let id):
            return "/api/v2/pokemon/\(id + 1)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPokemonName, .getPokemonDetails:
            return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getPokemonName, .getPokemonDetails:
            return URLEncoding.queryString
        }
    }
}
    
