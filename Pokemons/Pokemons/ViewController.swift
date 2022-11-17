//
//  ViewController.swift
//  Pokemons
//
//  Created by Александра Захаревич on 15.11.22.
//

import UIKit

class ViewController: UIViewController {
    
    var pokemonsName = [PokemonResults]()
    var pokemonsDetails = [PokemonDetails]()
    
    var limit = 5
    var totalPokemons = 0
    var index = 0
    var displayPokemons: [PokemonResults] = Array()
    
    private let pokemonCell = "PokemonCell"
    private let pokemonsTableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setDelegaties()
        
        pokemonsTableView.register(PokemonCell.self, forCellReuseIdentifier: pokemonCell)
        
        NetworkManager.getPokemonName { name in
            self.pokemonsName = name
            self.pokemonsTableView.reloadData()
            print("You get pokemons name")
            
        } failure: {
            print("You don't get pokemons name")
        }
        
        // MARK - pagination
//        totalPokemons = pokemonsName.count
//        while index < limit {
//            displayPokemons.append(pokemonsName[index])
//            index = index + 1
//        }
    }
}

private extension ViewController {
    func setupViews() {
        view.backgroundColor = .white
        pokemonsTableView.backgroundColor = .blue
        view.addSubview(pokemonsTableView)
        
    }
    
    func setDelegaties() {
        pokemonsTableView.delegate = self
        pokemonsTableView.dataSource = self
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pokemonsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pokemonsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pokemonsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonsName.count
//        return displayPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pokemonCell, for: indexPath) as! PokemonCell
        cell.setupCell(name: pokemonsName[indexPath.row])
//        cell.setupCell(name: displayPokemons[indexPath.row])
        return cell
    }
    
    // MARK - pagination
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//                if indexPath.row == displayPokemons.count - 1 {
//                    var index = displayPokemons.count - 1
//                    if index + 5 > pokemonsName.count - 1 {
//                        limit = pokemonsName.count - index
//                    } else {
//                        while index < limit {
//                            displayPokemons.append(pokemonsName[index])
//                            index = index + 1
//                        }
//                        self.perform(#selector(loadTable), with: nil, afterDelay: 0.5)
//                    }
//                }
//    }
//
//    @objc func loadTable() {
//        self.pokemonsTableView.reloadData()
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = PokemonDetailsVC()
        NetworkManager.getPokemonDetails(id: indexPath.row, success: { [weak self]  details in
            self?.navigationController?.pushViewController(detailsVC, animated: true)
            detailsVC.setupDetails(details: details)
            print("You get pokemons details")
        }) {
            print("You don't get pokemons details")
        }
            
            
        
//        navigationController?.pushViewController(detailsVC, animated: true)
//        present(detailsVC, animated: true)
        print("Select row")
    }
}
