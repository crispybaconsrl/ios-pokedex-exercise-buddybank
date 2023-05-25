//
//  PokemonDetails.swift
//  Pokemon
//
//  Created by Luca Davanzo on 24/05/23.
//

struct PokemonDetail: Decodable {
    
    // MARK: - Public variables -
    
    let name: String
    let sprites: PokemonSprites
    let statistics: [PokemonStatistics]
    let types: [PokemonType]
    
    // MARK: - Codekeys -
    
    private enum CodingKeys: String, CodingKey {
        case name
        case sprites
        case types
        case stats
    }
    
    // MARK: - Constructors -
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.sprites = try container.decode(PokemonSprites.self, forKey: .sprites)
        self.statistics = try container.decode([PokemonStatistics].self, forKey: .stats)
        self.types = try container.decode([PokemonType].self, forKey: .types)
    }
    
    // MARK: - Public methods -
    
    func getTypeNames() -> [String] {
        return self.types.map({ $0.type.name }).sorted()
    }
    
    func getStatisticNames() -> [String] {
        return self.statistics.map({ $0.details.name }).sorted()
    }
    
}
