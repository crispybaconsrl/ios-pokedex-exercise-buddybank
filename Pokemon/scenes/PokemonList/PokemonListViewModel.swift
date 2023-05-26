//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import Foundation

class PokemonListViewModel: BaseViewModel {
    
    private var pokemons: PokemonList?
    
    required init() {
        super.init()
    }
    
    func getPokemon(at index: Int) -> Pokemon? {
        if let pokemons = self.pokemons, pokemons.results.count > index - 1 {
            return pokemons.results[index]
        }
        return nil
    }
    
}

extension PokemonListViewModel: BaseViewModelDataSource {
    
    func getData() -> PokemonList? {
        return self.pokemons
    }
    
}

extension PokemonListViewModel: DataFetcher {
    
    func fetchData() {
        let request = PokemonRequest()
        request.getPokemonList { [weak self] result in
            switch result {
            case .success(let data):
                self?.pokemons = data
                self?.delegate?.reloadNeeded?()
            case .failure(let error):
                print("Request error: \(error)")
            }
        }
    }
    
}
