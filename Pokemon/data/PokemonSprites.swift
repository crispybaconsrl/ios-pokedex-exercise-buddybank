//
//  PokemonSprites.swift
//  Pokemon
//
//  Created by Luca Davanzo on 24/05/23.
//

struct PokemonSprites: Codable {
 
    let backDefault: String?
    let frontDefault: String?
    
    // MARK: - Codekeys -
    
    private enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case frontDefault = "front_default"
    }
    
}
