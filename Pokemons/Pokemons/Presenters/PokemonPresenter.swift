//
//  PokemonPresenter.swift
//  Pokemons
//
//  Created by Александра Захаревич on 20.11.22.
//VC


protocol PokemonViewProtocol: AnyObject {
    func internetEnabled()
    func internetDisabled()
    func showErrorMessage()
    func showPokemonFromAPI(pokemon: PokemonDetails)
    func showPokemonFromRealm(pokemon: RealmPokemonModel)
}

protocol PokemonPresenterProtocol {
    init(view : PokemonViewProtocol )
    func checkInternetConnection()
    func getPokemonFromAPI(id: Int)
    func cachePokemon(pokemon: PokemonDetails)
    func getPokemonFromRealm(pokemonName: String)
}


class PokemonPresenter : PokemonPresenterProtocol {
    
    weak var view : PokemonViewProtocol?
    
    required init(view : PokemonViewProtocol ) {
        self.view = view
    }
    
    func checkInternetConnection() {
        let isConnected  = NetworkMonitor.shared.isConnected
        if isConnected {
            view?.internetEnabled()
        } else {
            view?.internetDisabled()
        }
    }
    
    func getPokemonFromAPI(id: Int) {
        NetworkManager.getPokemonDetails(id: id, success: { [weak self]  details  in
            self?.view?.showPokemonFromAPI(pokemon: details)
            print("You get pokemons details")
        }) {
            self.view?.showErrorMessage()
            print("You don't get pokemons details")
        }
    }
    
    func cachePokemon(pokemon: PokemonDetails) {
        let currentCacheArray = RealmManager.shared.readPokemons()
        if !currentCacheArray.contains(where: {$0.pokemonName == pokemon.name}) {
            guard  let pokemonImage = pokemon.sprites?.front_default,
                  let pokemonName = pokemon.name,
                  let pokemonWeight = pokemon.weight,
                  let pokemonHeight = pokemon.height,
                  let pokemonTypes = pokemon.types.first?.type?.name
            else {return}
            RealmManager.shared.savePokemons(object: RealmPokemonModel(pokemonImage: pokemonImage, pokemonName: pokemonName, pokemonWeight: pokemonWeight, pokemonHeight: pokemonHeight, pokemonTypes: pokemonTypes))
        }
    }
    
    func getPokemonFromRealm(pokemonName: String) {
        let name = pokemonName
        let realmPokemons = RealmManager.shared.readPokemons()
        if realmPokemons.contains(where: {$0.pokemonName == name}) {
            guard let pokemon = realmPokemons.filter({$0.pokemonName == name}).first else {return}
            view?.showPokemonFromRealm(pokemon: pokemon)
        } else {
            view?.showErrorMessage()
        }
    }
    
}
