//
//  PokemonListViewControllerView.swift
//  Pokemons
//
//  Created by Александра Захаревич on 20.11.22.
//

import UIKit

class PokemonListViewControllerView : UIView {
    
     private var firstAppear = true
     let pokemonsTableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
         tableView.register(PokemonCell.self, forCellReuseIdentifier: String(describing: PokemonCell.self))
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if firstAppear {
            layoutElements()
            firstAppear = false
        }
    }
    
    private func layoutElements() {
        layoutPokemonsTableView()
    }
    
    private func layoutPokemonsTableView(){
        addSubview(pokemonsTableView)
        NSLayoutConstraint.activate([
            pokemonsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            pokemonsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pokemonsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pokemonsTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -safeAreaInsets.bottom)
        ])
    }
    
}

