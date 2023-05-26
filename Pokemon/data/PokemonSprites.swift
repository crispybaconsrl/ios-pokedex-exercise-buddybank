//
//  PokemonSprites.swift
//  Pokemon
//
//  Created by Luca Davanzo on 24/05/23.
//

struct PokemonSprites: Codable {
    
    let backDefault: String?
    let frontDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    
    // MARK: - Codekeys -
    
    private enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case frontDefault = "front_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
    
}
