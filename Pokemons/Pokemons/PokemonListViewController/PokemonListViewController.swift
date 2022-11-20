//
//  PokemonListViewController.swift
//  Pokemons
//
//  Created by Александра Захаревич on 20.11.22.
//

import UIKit

fileprivate struct Constants {
}

class PokemonListViewController : UIViewController {
    
    var presenter : PokemonListPresenterProtocol?
    private var isConnected = true
    private var pokemonNamesFromAPI = [PokemonResults]()
    private var pokemonsNamesFromRealm = [RealmNameModel]()
    
    
    private var contentView: PokemonListViewControllerView {
        view as! PokemonListViewControllerView
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        PokemonListConfigurator.shared.configure(view: self)
        setupDelegates()
        presenter?.checkInternetConnection()
    }
    
    override func loadView() {
        self.view = PokemonListViewControllerView()
    }
    
    private func setupDelegates() {
        contentView.pokemonsTableView.delegate = self
        contentView.pokemonsTableView.dataSource = self
    }
}

extension PokemonListViewController : PokemonListViewProtocol {
    func showPokemonsNamesFromRealm(names: [RealmNameModel]) {
        self.pokemonsNamesFromRealm = names
        contentView.pokemonsTableView.reloadData()
    }
    
    func showPokemonsNamesFromAPI(names: [PokemonResults]) {
        self.pokemonNamesFromAPI = names
        presenter?.cachePokemonsNames(pokemonsNames: names)
        contentView.pokemonsTableView.reloadData()
    }
    
    func showErrorMessage() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func internetEnabled() {
        isConnected = true
        presenter?.getPokemonsNameFromAPI()
    }
    
    func internetDisabled() {
        isConnected = false
        presenter?.getPokemonsNamesFromRealm()
    }
    
    
}

extension  PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isConnected {
            return pokemonNamesFromAPI.count
        } else {
            return pokemonsNamesFromRealm.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PokemonCell.self), for: indexPath) as! PokemonCell
        if isConnected {
            guard let name = pokemonNamesFromAPI[indexPath.row].name  else {return cell}
            cell.setupCell(name: name)
            cell.selectionStyle = .none
        } else {
            cell.setupCell(name: pokemonsNamesFromRealm[indexPath.row].pokemonName)
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonVC = PokemonViewController()
        if isConnected {
            guard let name = pokemonNamesFromAPI[indexPath.row].name else {return}
            pokemonVC.setupPokemon(index: indexPath.row, name: name)
        } else {
            pokemonVC.setupPokemon(index: indexPath.row, name: pokemonsNamesFromRealm[indexPath.row].pokemonName)
        }
        navigationController?.pushViewController(pokemonVC, animated: true)
    }
}
