//
//  PokemonViewController.swift
//  Pokemons
//
//  Created by Александра Захаревич on 20.11.22.
//

import UIKit

fileprivate struct Constants {
}

class PokemonViewController : UIViewController {
    
    var presenter : PokemonPresenterProtocol?
    private var index = 0
    private var name = ""
    
    private var contentView: PokemonViewControllerView {
        view as! PokemonViewControllerView
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        PokemonConfigurator.shared.configure(view: self)
        setupTargets()
        presenter?.checkInternetConnection()
        navigationItem.hidesBackButton = true
        
    }
    
    override func loadView() {
        self.view = PokemonViewControllerView()
    }
    
    func setupPokemon(index: Int, name: String) {
        self.index = index
        self.name = name
    }
    
    private func setupTargets() {
        contentView.returnButton.addTarget(self, action: #selector(returnButtonWasPressed), for:  .touchUpInside)
    }
    
    private func setupPokemonFromAPI(pokemon: PokemonDetails){
        guard let name = pokemon.name,
              let weight = pokemon.weight,
              let height = pokemon.height,
              let imageURLString = pokemon.sprites?.front_default,
              let types = pokemon.types.first?.type?.name
        else {
            let alert = UIAlertController(title: "Error", message: "Pokémon not in cache", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
            return}
        presenter?.cachePokemon(pokemon: pokemon)
        contentView.pokemonImageView.load(url: imageURLString)
        contentView.pokemonNameLabel.text = "Name: \(name)"
        contentView.pokemonTypeLabel.text = "Type: \(types)"
        contentView.pokemonWeightLabel.text = "Weight: \(weight) kg"
        contentView.pokemonHeightLabel.text = "Height: \(height) cm"
    }
    
    private func setupPokemonFromRealm(pokemon: RealmPokemonModel) {
        let name = pokemon.pokemonName
        let weight = pokemon.pokemonWeight
        let height = pokemon.pokemonHeight
        let imageURLString = pokemon.pokemonImage
        let types = pokemon.pokemonTypes
        
        contentView.pokemonImageView.load(url: imageURLString)
        contentView.pokemonNameLabel.text = "Name: \(name)"
        contentView.pokemonTypeLabel.text = "Type: \(types)"
        contentView.pokemonWeightLabel.text = "Weight: \(weight) kg"
        contentView.pokemonHeightLabel.text = "Height: \(height) cm"
    }
}

extension PokemonViewController : PokemonViewProtocol {
    func showPokemonFromRealm(pokemon: RealmPokemonModel) {
        setupPokemonFromRealm(pokemon: pokemon)
    }
    
    func showPokemonFromAPI(pokemon: PokemonDetails) {
        setupPokemonFromAPI(pokemon: pokemon)
    }
    
    func showErrorMessage() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong!!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func internetEnabled() {
        presenter?.getPokemonFromAPI(id: index)
    }
    
    func internetDisabled() {
        presenter?.getPokemonFromRealm(pokemonName: name)
    }
    
    
}
//MARK: - objc метод
extension PokemonViewController {
    @objc private func returnButtonWasPressed() {
        navigationController?.popViewController(animated: true)
    }
}
