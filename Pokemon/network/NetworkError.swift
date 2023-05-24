//
//  NetworkError.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

enum NetworkError: Error {
    case invalidResponse
    case decodingFailed
    case generic
}
