//
//  PokemonViewControllerView.swift
//  Pokemons
//
//  Created by Александра Захаревич on 20.11.22.
//

import UIKit

class PokemonViewControllerView : UIView {
    
    private var firstAppear = true
    let pokemonImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 75
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .italicSystemFont(ofSize: 20)
        return label
    }()
    
    let pokemonTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .italicSystemFont(ofSize: 20)
        return label
    }()
    
    let pokemonWeightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .italicSystemFont(ofSize: 20)
        return label
    }()
    
    let pokemonHeightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .italicSystemFont(ofSize: 20)
        return label
    }()
    
    let returnButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 2.5
        button.setTitle("Back to list", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        if firstAppear {
            layoutElements()
            firstAppear = false
        }
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        layoutPokemonImageView()
        layoutPokemonNameLabel()
        layoutPokemonTypeLabel()
        layoutPokemonWeightLabel()
        layoutPokemonHeightLabel()
        layoutReturnButton()
    }
    
    private func layoutPokemonImageView() {
        addSubview(pokemonImageView)
        NSLayoutConstraint.activate([
            pokemonImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80),
            pokemonImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 150),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func layoutPokemonNameLabel() {
        addSubview(pokemonNameLabel)
        NSLayoutConstraint.activate([
            pokemonNameLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant:  25),
            pokemonNameLabel.heightAnchor.constraint(equalToConstant: 30),
            pokemonNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func layoutPokemonTypeLabel() {
        addSubview(pokemonTypeLabel)
        NSLayoutConstraint.activate([
            pokemonTypeLabel.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: 20),
            pokemonTypeLabel.heightAnchor.constraint(equalToConstant: 30),
            pokemonTypeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func layoutPokemonWeightLabel() {
        addSubview(pokemonWeightLabel)
        NSLayoutConstraint.activate([
            pokemonWeightLabel.topAnchor.constraint(equalTo: pokemonTypeLabel.bottomAnchor, constant: 20),
            pokemonWeightLabel.heightAnchor.constraint(equalToConstant: 30),
            pokemonWeightLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func layoutPokemonHeightLabel() {
        addSubview(pokemonHeightLabel)
        NSLayoutConstraint.activate([
            pokemonHeightLabel.topAnchor.constraint(equalTo: pokemonWeightLabel.bottomAnchor, constant: 20),
            pokemonHeightLabel.heightAnchor.constraint(equalToConstant: 30),
            pokemonHeightLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func layoutReturnButton() {
        addSubview(returnButton)
        NSLayoutConstraint.activate([
            returnButton.topAnchor.constraint(equalTo: pokemonHeightLabel.bottomAnchor, constant: 20),
            returnButton.heightAnchor.constraint(equalToConstant: 50),
            returnButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            returnButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    

}

