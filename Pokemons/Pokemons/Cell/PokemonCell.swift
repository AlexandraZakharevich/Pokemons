//
//  PokemonCell.swift
//  Pokemons
//
//  Created by Александра Захаревич on 15.11.22.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    
    let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .italicSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pokemon Name"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PokemonCell {
    func setupCell(name: String) {
        pokemonNameLabel.text = name
    }
}

private extension PokemonCell {
    func setup() {
        addSubview(pokemonNameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pokemonNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            pokemonNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 15),
            pokemonNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5)
        ])
    }
}
