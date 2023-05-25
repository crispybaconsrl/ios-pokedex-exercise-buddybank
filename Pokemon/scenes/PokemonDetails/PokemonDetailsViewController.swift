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
        self.view.backgroundColor = .white
        
        if let viewModel = self.viewModel as? PokemonDetailsViewModel {
            viewModel.delegate = self
            viewModel.fetchData()
        }
        // TODO show loader until reloadNeeded
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pokemonDetailsView = PokemonDetailsView(frame: .zero)
        self.pokemonDetailsView?.attach(on: self.view)
        self.pokemonDetailsView?.pin.all()
    }
    
}

extension PokemonDetailsViewController: BaseViewModelDelegate {
    
    func reloadNeeded() {
        if let vm = self.viewModel as? PokemonDetailsViewModel,
           let data: PokemonDetail = vm.getData() {
//            self.title = data.name.capitalized
            self.pokemonDetailsView?.setupWith(details: data)
        }
        // TODO hide loader
    }
    
}
