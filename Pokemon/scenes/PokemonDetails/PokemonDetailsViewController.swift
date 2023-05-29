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

    private var pokemonDetailsView: PokemonDetailsView = PokemonDetailsView(frame: .zero)

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
        self.pokemonDetailsView.attach(on: self.view)
        self.pokemonDetailsView.pin.all()
    }
    
}

extension PokemonDetailsViewController: BaseViewModelDelegate {
    
    func reloadNeeded() {
        if let vm = self.viewModel as? PokemonDetailsViewModel,
           let data: PokemonDetail = vm.getData() {
            self.pokemonDetailsView.setupWith(details: data)
        }
        // TODO hide loader
    }
    
    func didReceiveError(error: Error) {
        DispatchQueue.main.async {
            self.displayNoDataView(true)
        }
    }
    
}
