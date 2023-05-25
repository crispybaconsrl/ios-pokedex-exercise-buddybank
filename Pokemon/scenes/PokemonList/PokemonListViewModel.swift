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
        print("list view model")
        
        let request = PokemonRequest()
        request.getPokemonDetails(pokemonId: 1) { result in
            switch result {
            case .success(let data):
                print("Received data: \(data)")
                print("Names: \(data.getTypeNames())")
                print("Stats: \(data.getStatisticNames())")
                
                
            case .failure(let error):
                print("Request error: \(error)")
            }
        }
        
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
        request.getPokemonList { result in
            switch result {
            case .success(let data):
                self.pokemons = data
                self.delegate?.reloadNeeded?()
            case .failure(let error):
                print("Request error: \(error)")
            }
        }
    }
    
}
