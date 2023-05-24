//
//  NetworkHelper.swift
//  Pokemon
//
//  Created by Luca Davanzo on 24/05/23.
//

import Foundation

enum PokemonEndpoint {
    case pokemonList
    case pokemonDetails(Int)
    
    var rawValue: String {
        switch self {
        case .pokemonList:
            return "pokemon"
        case .pokemonDetails(let index):
            return "pokemon/\(index)"
        }
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkHelper {
    
    static let baseUrl = "https://pokeapi.co/api/v2/"
    
    static func createRequest(url: String, endPoint: String?, method: HttpMethod? = HttpMethod.get) -> URLRequest? {
        var finalUrl: String = url
        if let e = endPoint {
            finalUrl += "\(e)"
        }
        guard let url = URL(string: finalUrl) else {
            return nil
        }
        print("request on \(finalUrl)")
        var request = URLRequest(url: url)
        request.httpMethod = method?.rawValue ?? HttpMethod.get.rawValue
        return URLRequest(url: url)
    }
    
}
