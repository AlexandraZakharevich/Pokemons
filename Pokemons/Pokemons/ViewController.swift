//
//  ViewController.swift
//  Pokemons
//
//  Created by Александра Захаревич on 15.11.22.
//

import UIKit

class ViewController: UIViewController {
    
    var pokemonsName = [PokemonResults]()
    
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
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pokemonCell, for: indexPath) as! PokemonCell
        cell.setupCell(name: pokemonsName[indexPath.row])
        return cell
    }
}
