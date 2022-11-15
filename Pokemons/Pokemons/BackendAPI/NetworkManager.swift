//
//  NetworkManager.swift
//  Pokemons
//
//  Created by Александра Захаревич on 15.11.22.
//

import Foundation
import Moya
import Moya_ObjectMapper

class NetworkManager {
    static let provider = MoyaProvider<BackendAPI>(plugins: [NetworkLoggerPlugin()])
    
    static func getPokemonName(success: (([PokemonResults]) ->())?, failure: (() -> ())? = nil) {
        provider.request(.getPokemonName) { result in
            switch result {
            case .success(let response):
                guard let result = try? response.mapArray(PokemonResults.self, atKeyPath: "results")
                
                else {
                    failure?()
                    print("Не удалось распарсить ответ от сервера")
                    return
                }
                print("Удалось распарсить ответ от сервера")
                success?(result)
            case .failure(_):
                print("Error")
                failure?()
            }
        }
    }
}
