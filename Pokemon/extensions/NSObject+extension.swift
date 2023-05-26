//
//  NSObject+extension.swift
//  Pokemon
//
//  Created by Luca Davanzo on 25/05/23.
//

import Foundation

extension Decodable {
    func convertObjectToDictionary() -> [String: Any] {
        let mirror = Mirror(reflecting: self)
        var dictionary: [String: Any] = [:]
        
        for (key, value) in mirror.children {
            guard let key = key else {
                continue
            }
            
            dictionary[key] = value
        }
        
        return dictionary
    }
}
