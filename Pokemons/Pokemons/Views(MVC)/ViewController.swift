//
//  ViewController.swift
//  Pokemons
//
//  Created by Александра Захаревич on 15.11.22.
//

//import UIKit
//
//class ViewController: UIViewController {
//    
//    var pokemonsName = [PokemonResults]()
//    var realmPokemonNames = [RealmNameModel]()
//    var isConnected = true
////    var pokemonsDetails = [PokemonDetails]()
//    
////    var limit = 5
////    var totalPokemons = 0
////    var index = 0
////    var displayPokemons: [PokemonResults] = Array()
//    
//    private let pokemonCell = "PokemonCell"
//    private let pokemonsTableView: UITableView = {
//        let tableView = UITableView()
//        tableView.bounces = false
//        tableView.showsVerticalScrollIndicator = false
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//        setupConstraints()
//        setDelegaties()
//        
//        pokemonsTableView.register(PokemonCell.self, forCellReuseIdentifier: pokemonCell)
//        
//        setupName()
//        
//        // MARK - pagination
////        totalPokemons = pokemonsName.count
////        while index < limit {
////            displayPokemons.append(pokemonsName[index])
////            index = index + 1
////        }
//    }
//}
//
//private extension ViewController {
//    func setupViews() {
//        view.backgroundColor = .white
//        pokemonsTableView.separatorStyle = .none
//        view.addSubview(pokemonsTableView)
//    }
//    
//    func setDelegaties() {
//        pokemonsTableView.delegate = self
//        pokemonsTableView.dataSource = self
//    }
//    
//    func codeStatusIsInvalid() {
//        let alert = UIAlertController(title: "Error", message: "Check your connection", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default)
//        alert.addAction(okAction)
//        self.present(alert, animated: true)
//    }
//    
//    func setupName() {
//        let isConnected  = NetworkMonitor.shared.isConnected
//        self.isConnected = isConnected
//        if isConnected {
//            getNamesFromAPI()
//        } else {
//            getNamesFromRealm()
//        }
//    }
//    
//    func getNamesFromAPI() {
//        NetworkManager.getPokemonName { name in
//            self.pokemonsName = name
//            self.setCacheNames(pokemonsNames: name)
//            self.pokemonsTableView.reloadData()
//            print("You get pokemons name")
//            
//        } failure: {
//            self.codeStatusIsInvalid()
//            print("You don't get pokemons name")
//        }
//    }
//    
//    func getNamesFromRealm() {
//        realmPokemonNames = RealmManager.shared.readNames()
//    }
//    
//    func setCacheNames(pokemonsNames: [PokemonResults]) {
//        let currentCacheArray = RealmManager.shared.readNames()
//        if !currentCacheArray.isEmpty{
//            var stringArray: [String] = []
//            for name in currentCacheArray {
//                stringArray.append(name.pokemonName)
//            }
//            for  name in pokemonsNames {
//                guard let name = name.name  else {return}
//                if  !stringArray.contains(name) {
//                    RealmManager.shared.saveNames(object: RealmNameModel(pokemonName: name))
//                }
//            }
//        } else {
//            for name in pokemonsNames {
//                guard let name = name.name  else {return}
//                RealmManager.shared.saveNames(object: RealmNameModel(pokemonName: name))
//            }
//        }
//    }
//    
//    // Настраиваем вызов деталей покемона в зависимости есть ли соединение с сетью
//    func setupPokemon(indexPath: IndexPath) {
//        let isConnected  = NetworkMonitor.shared.isConnected
//        self.isConnected = isConnected
//        if isConnected {
//            getPokemonFromAPI(indexPath: indexPath)
//        } else {
//            getPokemonFromRealm(index: indexPath.row)
//        }
//    }
//    
//    // Берем покемона из апи
//    func getPokemonFromAPI(indexPath: IndexPath) {
//        let detailsVC = PokemonDetailsVC()
//        NetworkManager.getPokemonDetails(id: indexPath.row, success: { [weak self]  details  in
//            detailsVC.setupDetails(details: details)
//            self?.navigationController?.pushViewController(detailsVC, animated: true)
//            print("You get pokemons details")
//        }) {
//            self.codeStatusIsInvalid()
//            print("You don't get pokemons details")
//        }
//    }
//    
//    // Берем покемона из реалма.
//    func getPokemonFromRealm(index: Int) {
//        let detailsVC = PokemonDetailsVC()
//        let name = realmPokemonNames[index].pokemonName
//        let realmPokemons = RealmManager.shared.readPokemons()
//        if realmPokemons.contains(where: {$0.pokemonName == name}) {
//            guard let pokemon = realmPokemons.filter({$0.pokemonName == name}).first else {return}
//            detailsVC.setupDetailsFromRealm(details: pokemon)
//            navigationController?.pushViewController(detailsVC, animated: true)
//        } else {
//            detailsVC.setupDetails(details: nil)
//            navigationController?.pushViewController(detailsVC, animated: true)
//        }
//    }
//    
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            pokemonsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            pokemonsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            pokemonsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            pokemonsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
//}
//
//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
//}
//
//extension ViewController: UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isConnected {
//            return pokemonsName.count
//        } else {
//            return realmPokemonNames.count
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: pokemonCell, for: indexPath) as! PokemonCell
//        if isConnected {
//            guard let name = pokemonsName[indexPath.row].name  else {return cell}
//            cell.setupCell(name: name)
//            cell.selectionStyle = .none
//        } else {
//            cell.setupCell(name: realmPokemonNames[indexPath.row].pokemonName)
//            cell.selectionStyle = .none
//        }
//        return cell
//    }
//    
//    // MARK - pagination
//    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//    //                if indexPath.row == displayPokemons.count - 1 {
//    //                    var index = displayPokemons.count - 1
//    //                    if index + 5 > pokemonsName.count - 1 {
//    //                        limit = pokemonsName.count - index
//    //                    } else {
//    //                        while index < limit {
//    //                            displayPokemons.append(pokemonsName[index])
//    //                            index = index + 1
//    //                        }
//    //                        self.perform(#selector(loadTable), with: nil, afterDelay: 0.5)
//    //                    }
//    //                }
//    //    }
//    //
//    //    @objc func loadTable() {
//    //        self.pokemonsTableView.reloadData()
//    //    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        setupPokemon(indexPath: indexPath)
//    }
//}

