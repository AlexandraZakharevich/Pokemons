//
//  PokemonDetailsVC.swift
//  Pokemons
//
//  Created by Александра Захаревич on 15.11.22.
//

import UIKit

class PokemonDetailsVC: UIViewController {
    
    private let pokemonImage: CachedImageView = {
        let imageView = CachedImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 75
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pokemonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .italicSystemFont(ofSize: 20)
        return label
    }()
    
    private let pokemonType: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .italicSystemFont(ofSize: 20)
        return label
    }()
    
    private let pokemonWeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .italicSystemFont(ofSize: 20)
        return label
    }()
    
    private let pokemonHeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .italicSystemFont(ofSize: 20)
        return label
    }()
    
    
    private lazy var returnButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 2.5
        button.setTitle("Back to list", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(returnButtonTapped), for: .allTouchEvents)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
    }
}

extension PokemonDetailsVC {
    func setupDetails(details: PokemonDetails?) {
        guard let name = details?.name,
              let weight = details?.weight,
              let height = details?.height,
              let imageURLString = details?.sprites?.front_default,
              let types = details?.types.first?.type?.name
        else {
            // MARK: - Сделать алерт что не закеширован покемон
            return}
        setCachePokemon(pokemon: details)
        pokemonImage.load(url: imageURLString)
        pokemonName.text = "Name: \(name)"
        pokemonType.text = "Type: \(types)"
        pokemonWeight.text = "Weight: \(weight) kg"
        pokemonHeight.text = "Height: \(height) cm"
    }
    
    func setupDetailsFromRealm(details: RealmPokemonModel) {
        let name = details.pokemonName
        let weight = details.pokemonWeight
        let height = details.pokemonHeight
        let imageURLString = details.pokemonImage
        let types = details.pokemonTypes
        
        pokemonImage.load(url: imageURLString)
        pokemonName.text = "Name: \(name)"
        pokemonType.text = "Type: \(types)"
        pokemonWeight.text = "Weight: \(weight) kg"
        pokemonHeight.text = "Height: \(height) cm"
    }
    
    func setCachePokemon(pokemon: PokemonDetails?){
        guard let pokemon  else {return}
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
    
}

private extension PokemonDetailsVC {
    func setupViews() {
        view.addSubview(pokemonImage)
        view.addSubview(pokemonName)
        view.addSubview(pokemonType)
        view.addSubview(pokemonWeight)
        view.addSubview(pokemonHeight)
        view.addSubview(returnButton)
    }
    
    @objc func returnButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pokemonImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            pokemonImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImage.heightAnchor.constraint(equalToConstant: 150),
            pokemonImage.widthAnchor.constraint(equalToConstant: 150),
            
            pokemonName.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor, constant:  25),
            pokemonName.heightAnchor.constraint(equalToConstant: 30),
            pokemonName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pokemonType.topAnchor.constraint(equalTo: pokemonName.bottomAnchor, constant: 20),
            pokemonType.heightAnchor.constraint(equalToConstant: 30),
            pokemonType.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pokemonWeight.topAnchor.constraint(equalTo: pokemonType.bottomAnchor, constant: 20),
            pokemonWeight.heightAnchor.constraint(equalToConstant: 30),
            pokemonWeight.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pokemonHeight.topAnchor.constraint(equalTo: pokemonWeight.bottomAnchor, constant: 20),
            pokemonHeight.heightAnchor.constraint(equalToConstant: 30),
            pokemonHeight.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            returnButton.topAnchor.constraint(equalTo: pokemonHeight.bottomAnchor, constant: 50),
            returnButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant:  16),
            returnButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            returnButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
