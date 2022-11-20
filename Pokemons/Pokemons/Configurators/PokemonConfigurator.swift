//
//  PokemonConfigurator.swift
//  Pokemons
//
//  Created by Александра Захаревич on 20.11.22.
//VC


protocol PokemonConfiguratorProtocol {
    func configure(view: PokemonViewController)
}

class PokemonConfigurator: PokemonConfiguratorProtocol {
    
    static let shared = PokemonConfigurator()
    
    func configure(view: PokemonViewController) {
        let presenter = PokemonPresenter(view: view)
        view.presenter = presenter
    }
    
}
