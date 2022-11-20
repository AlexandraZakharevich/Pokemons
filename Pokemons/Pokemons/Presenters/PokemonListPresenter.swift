//
//  PokemonListPresenter.swift
//  Pokemons
//
//  Created by Александра Захаревич on 20.11.22.
//VC


protocol PokemonListViewProtocol: AnyObject {
    func internetEnabled()
    func internetDisabled()
    func showPokemonsNamesFromAPI(names: [PokemonResults])
    func showErrorMessage()
    func showPokemonsNamesFromRealm(names: [RealmNameModel])
}

protocol PokemonListPresenterProtocol {
    init(view : PokemonListViewProtocol )
    func checkInternetConnection()
    func getPokemonsNameFromAPI()
    func cachePokemonsNames(pokemonsNames: [PokemonResults])
    func getPokemonsNamesFromRealm()
}


class PokemonListPresenter : PokemonListPresenterProtocol {
    
    weak var view : PokemonListViewProtocol?
    
    required init(view : PokemonListViewProtocol ) {
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
    
    func getPokemonsNameFromAPI() {
        NetworkManager.getPokemonName { [weak self] name in
            self?.view?.showPokemonsNamesFromAPI(names: name)
            print("You get pokemons name")
        } failure: {
            self.view?.showErrorMessage()
            print("You don't get pokemons name")
        }
    }
    
    func cachePokemonsNames(pokemonsNames: [PokemonResults]) {
        let currentCacheArray = RealmManager.shared.readNames()
        if !currentCacheArray.isEmpty{
            var stringArray: [String] = []
            for name in currentCacheArray {
                stringArray.append(name.pokemonName)
            }
            for  name in pokemonsNames {
                guard let name = name.name  else {return}
                if  !stringArray.contains(name) {
                    RealmManager.shared.saveNames(object: RealmNameModel(pokemonName: name))
                }
            }
        } else {
            for name in pokemonsNames {
                guard let name = name.name  else {return}
                RealmManager.shared.saveNames(object: RealmNameModel(pokemonName: name))
            }
        }
    }
    
    func getPokemonsNamesFromRealm() {
        let realmPokemonNames = RealmManager.shared.readNames()
        if realmPokemonNames.isEmpty {
            view?.showErrorMessage()
        } else {
            view?.showPokemonsNamesFromRealm(names: realmPokemonNames)
        }
    }
    
}
