//
//  PokemonDetailsViewController.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import UIKit

import PinLayout

class PokemonDetailsViewController: BaseViewController {

    // MARK: - Private properties -
    
    private var pokemonDetailsView: PokemonDetailsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokemon Details"
        print("PokemonDetailsViewController")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pokemonDetailsView = PokemonDetailsView(frame: .zero)
        self.pokemonDetailsView?.attach(on: self.view)
        self.pokemonDetailsView?.pin.all()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pokemonDetailsView?.setupWith(pokemon: nil)
    }

}
