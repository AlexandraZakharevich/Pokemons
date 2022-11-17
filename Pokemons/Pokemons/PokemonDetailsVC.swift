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
//        imageView.image = UIImage(named: "arrow")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 75
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    private let pokemonName = PokemonDetailsLabel()
    private let typeEGGrass = PokemonDetailsLabel()
    private let pokemonWeight = PokemonDetailsLabel()
    private let pokemonHeight = PokemonDetailsLabel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let pokemonName: PokemonDetailsLabel = {
        let label = PokemonDetailsLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
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
    
    }
}

extension PokemonDetailsVC {
    func setupDetails(details: PokemonDetails) {
        guard let name = details.name,
              let weight = details.weight,
              let height = details.height,
              let imageURLString = details.sprites?.front_default,
              let  types = details.types.first
        else {return}
        pokemonName.text = "Name: \(name)"
        pokemonWeight.text = "Weight: \(weight) kg"
        pokemonHeight.text = "Height: \(height) cm"
        pokemonImage.setImageFromUrl(imageURLString)
        typeEGGrass.text = "\(types)"
        
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
//        view.addSubview(titleLabel)
//        NSLayoutConstraint.activate([
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
        
    }
    
    @objc func returnButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
//        dismiss(animated: true)
        print("push back")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pokemonImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            pokemonImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImage.heightAnchor.constraint(equalToConstant: 150),
            pokemonImage.widthAnchor.constraint(equalToConstant: 150),
            
            pokemonName.topAnchor.constraint(equalTo: view.topAnchor, constant:  50),
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
