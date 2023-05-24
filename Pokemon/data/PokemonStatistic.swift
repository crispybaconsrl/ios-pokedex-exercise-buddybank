//
//  PokemonStatistic.swift
//  Pokemon
//
//  Created by Luca Davanzo on 24/05/23.
//

import Foundation

struct PokemonStatistics: Decodable {
    let baseStat: Int
    let effort: Int
    let details: PokemonStatisticDetail
    
    // MARK: - Codekeys -
    
    private enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case details = "stat"
    }
    
    // MARK: - Constructors -
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.baseStat = try container.decode(Int.self, forKey: .baseStat)
        self.effort = try container.decode(Int.self, forKey: .effort)
        self.details = try container.decode(PokemonStatisticDetail.self, forKey: .details)
    }
}

struct PokemonStatisticDetail: Decodable {
    let name: String
    let url: String
}
