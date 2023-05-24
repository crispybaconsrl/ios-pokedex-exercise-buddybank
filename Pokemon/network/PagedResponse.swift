//
//  PagedResponse.swift
//  Pokemon
//
//  Created by Luca Davanzo on 24/05/23.
//

import Foundation

struct PagedResponse<T: Codable>: Codable {
    let results: [T]
    let next: URL?
}
