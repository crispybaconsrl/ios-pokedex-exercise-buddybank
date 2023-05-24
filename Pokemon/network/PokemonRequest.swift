//
//  PokemonRequest.swift
//  Pokemon
//
//  Created by Luca Davanzo on 24/05/23.
//

import Foundation

class PokemonRequest: NetworkRequest {
    
    func getPokemonList(completion: @escaping (Result<PokemonList, Error>) -> Void) {
        let request = NetworkHelper.createRequest(url: NetworkHelper.baseUrl, endPoint: PokemonEndpoint.pokemonList.rawValue)
        guard let request = request else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        self.sendRequest(request: request, completion: completion)
    }
    
}

