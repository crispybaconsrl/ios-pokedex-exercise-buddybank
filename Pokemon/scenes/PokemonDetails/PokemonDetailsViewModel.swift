//
//  PokemonDetailsViewModel.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import Foundation

class PokemonDetailsViewModel: BaseViewModel {
    
    // MARK: - Private properties -
    
    private var pokemon: Pokemon?
    private var details: PokemonDetail?
    
    // MARK: - Constructors -
    
    required init() {
        super.init()
    }
    
    // MARK: - Public methods -
    
    func setup(with pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
}

extension PokemonDetailsViewModel: BaseViewModelDataSource {
    
    func getData() -> PokemonDetail? {
        return self.details
    }
    
}

extension PokemonDetailsViewModel: DataFetcher {
   
    func fetchData() {
        let request = PokemonRequest()
        if let id = self.pokemon?.id {
            request.getPokemonDetails(pokemonId: id) { result in
                switch result {
                case .success(let data):
                    self.details = data
                    self.delegate?.reloadNeeded?()
                case .failure(let error):
                    print("Request error: \(error)")
                }
            }
        } else {
            // TODO rise error
        }
    }
    
}
