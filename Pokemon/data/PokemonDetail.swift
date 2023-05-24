//
//  PokemonDetails.swift
//  Pokemon
//
//  Created by Luca Davanzo on 24/05/23.
//


struct PokemonDetail: Decodable {
    
    // MARK: - Public variables -
    
    //    name, images, stats and type.
    
    let name: String
    let sprites: PokemonSprites
    let types: [PokemonType]
    
    // MARK: - Codekeys -
    
    private enum CodingKeys: String, CodingKey {
        case name
        case sprites
        case types
    }
    
    // MARK: - Constructors -
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.sprites = try container.decode(PokemonSprites.self, forKey: .sprites)
        self.types = try container.decode([PokemonType].self, forKey: .types)
    }
    
    // MARK: - Public methods -
    
    func getTypeNames() -> [String] {
        return self.types.map({ $0.type.name }).sorted()
    }
    
}
