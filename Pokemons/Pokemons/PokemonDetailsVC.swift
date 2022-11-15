//
//  PokemonDetailsVC.swift
//  Pokemons
//
//  Created by Александра Захаревич on 15.11.22.
//

import UIKit

class PokemonDetailsVC: UIViewController {
    
    private let pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 75
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pokemonName = PokemonDetailsLabel(text: "Name:")
    private let typeEGGrass = PokemonDetailsLabel(text: "Type:")
    private let pokemonWeight = PokemonDetailsLabel(text: "Weight:")
    private let pokemonHeight = PokemonDetailsLabel(text: "Height: cm")
    
    private let returnButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 2.5
        button.setTitle("Back to list", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(returnButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    @objc func returnButtonTapped() {
        
    }
}

private extension PokemonDetailsVC {
    func setupViews() {
        pokemonImage.backgroundColor = .blue
        view.addSubview(pokemonImage)
        view.addSubview(pokemonName)
        view.addSubview(typeEGGrass)
        view.addSubview(pokemonWeight)
        view.addSubview(pokemonHeight)
        view.addSubview(returnButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pokemonImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            pokemonImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImage.heightAnchor.constraint(equalToConstant: 150),
            pokemonImage.widthAnchor.constraint(equalToConstant: 150),
            
            pokemonName.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor, constant:  50),
            pokemonName.heightAnchor.constraint(equalToConstant: 30),
            pokemonName.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            typeEGGrass.topAnchor.constraint(equalTo: pokemonName.bottomAnchor, constant: 20),
            typeEGGrass.heightAnchor.constraint(equalToConstant: 30),
            typeEGGrass.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            pokemonWeight.topAnchor.constraint(equalTo: typeEGGrass.bottomAnchor, constant: 20),
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
