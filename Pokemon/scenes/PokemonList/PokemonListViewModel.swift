//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import Foundation

class PokemonListViewModel: BaseViewModel {
    
    private var pokemons: PokemonList?
    private var filteredList: [Pokemon] = []
    
    required init() {
        super.init()
    }
    
    func getPokemon(at index: Int) -> Pokemon? {
        if self.filteredList.count > index - 1 {
            return self.filteredList[index]
        }
        return nil
    }
    
    func getPokemonList() -> [Pokemon] {
        return self.filteredList
    }
    
    func filterBy(text: String) {
        if text.isEmpty {
            self.filteredList = self.pokemons?.results ?? []
        } else {
            self.filteredList = self.pokemons?.results.filter { pokemon in
                pokemon.name.range(of: text, options: .caseInsensitive) != nil
            } ?? []
        }
        self.delegate?.reloadNeeded()
    }
    
}

extension PokemonListViewModel: BaseViewModelDataSource {
    
    func getData() -> PokemonList? {
        return self.pokemons
    }
    
}

extension PokemonListViewModel: DataFetcher {
   
    func fetchData(url: String? = nil) {
        let request = PokemonRequest()
        self.isLoading = true
        request.getPokemonList(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                let list = self?.pokemons?.results ?? []
                self?.pokemons = data
                self?.pokemons?.results = list + data.results
                self?.filteredList = self?.pokemons?.results ?? []
                self?.delegate?.reloadNeeded()
            case .failure(let error):
                self?.delegate?.didReceiveError(error: error)
            }
            self?.isLoading = false
        }
    }
    
    func loadMore() {
        if let next = self.pokemons?.next {
            self.fetchData(url: next)
        }
    }
    
}
