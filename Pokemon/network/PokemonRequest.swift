//
//  PokemonRequest.swift
//  Pokemon
//
//  Created by Luca Davanzo on 24/05/23.
//

import Foundation

class PokemonRequest: NetworkRequest {
    
    static let baseUrl = "https://pokeapi.co/api/v2/"
    
    // MARK: - Request section -
    
    static func createRequest(url: String, endPoint: String?, method: HttpMethod? = .get) -> URLRequest? {
        var finalUrl: String = url
        if let e = endPoint {
            finalUrl += "\(e)"
        }
        guard let url = URL(string: finalUrl) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method?.rawValue ?? HttpMethod.get.rawValue
        return URLRequest(url: url)
    }
    
    // MARK: - API -
    
    func getPokemonList(completion: @escaping (Result<PokemonList, Error>) -> Void) {
        let request = PokemonRequest.createRequest(url: PokemonRequest.baseUrl,
                                                  endPoint: PokemonEndpoint.pokemonList.rawValue)
        guard let request = request else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        self.sendRequest(request: request, completion: completion)
    }
    
    func getPokemonDetails(pokemon: Pokemon, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        guard let id = pokemon.id else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        self.getPokemonDetails(pokemonId: id, completion: completion)
    }

    func getPokemonDetails(pokemonId: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        let request = PokemonRequest.createRequest(url: PokemonRequest.baseUrl,
                                                  endPoint: PokemonEndpoint.pokemonDetails(pokemonId).rawValue)
        guard let request = request else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        self.sendRequest(request: request, completion: completion)
    }

    
}

