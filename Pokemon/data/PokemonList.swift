//
//  PokemonList.swift
//  Pokemon
//
//  Created by Luca Davanzo on 24/05/23.
//

import Foundation

struct PokemonList: Codable {
    let count: Int
    let next: String?
    let previous: String?
    var results: [Pokemon]
}
