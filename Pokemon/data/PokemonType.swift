//
//  PokemonType.swift
//  Pokemon
//
//  Created by Luca Davanzo on 24/05/23.
//

struct PokemonTypeDetail: Decodable {
    let name: String
    let url: String
}

struct PokemonType: Decodable {
    let slot: Int
    let type: PokemonTypeDetail
}
