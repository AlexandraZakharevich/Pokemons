//
//  PokemonDetailsLabel.swift
//  Pokemons
//
//  Created by Александра Захаревич on 15.11.22.
//

import UIKit

final class PokemonDetailsLabel: UILabel {
    convenience init(text: String) {
        self.init()
        configure(with: text)
    }
}
//MARK: - Private extension
private extension PokemonDetailsLabel {
    private func configure(with text: String) {
        self.text = text
        self.textColor = .black
//        self.textAlignment = .center
        self.font = .italicSystemFont(ofSize: 20)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
