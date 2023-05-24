//
//  Pokemon.swift
//  Pokemon
//
//  Created by Luca Davanzo on 24/05/23.
//

import Foundation

struct Pokemon: Codable {
    
    // MARK: - Private class variables -
    
    private static let imageBaseUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/{pokemonIndex}.png"
    
    // MARK: - Public variables -
    
    let name: String
    var url: String {
        didSet {
            print("asd")
            
        }
    }
    var imageUrl: String?
    
    // MARK: - Codekeys -
    
    private enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    // MARK: - Constructor -
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
        self.updateImageUrl()
    }
    
    // MARK: - Private methods -
    
    private mutating func updateImageUrl() {
        if let url = URL(string: self.url) {
            self.imageUrl = Pokemon.imageBaseUrl.replacingOccurrences(of: "{pokemonIndex}", with: url.lastPathComponent)
        }
    }
    
}
