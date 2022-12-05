//
//  PokemonListConfigurator.swift
//  Pokemons
//
//  Created by Александра Захаревич on 20.11.22.
//VC


protocol PokemonListConfiguratorProtocol {
    func configure(view: PokemonListViewController)
}

class PokemonListConfigurator: PokemonListConfiguratorProtocol {

    static let shared = PokemonListConfigurator()

    func configure(view: PokemonListViewController) {
        let presenter = PokemonListPresenter(view: view)
        view.presenter = presenter
    }

}
