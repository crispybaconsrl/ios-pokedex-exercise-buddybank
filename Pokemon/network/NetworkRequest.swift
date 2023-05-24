//
//  NetworkRequest.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import Foundation

protocol NetworkRequestProtocol {
    func sendRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkRequest: NetworkRequestProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func sendRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
         let task = urlSession.dataTask(with: url) { data, response, error in
             if let error = error {
                 completion(.failure(error))
                 return
             }
             
             guard let responseData = data else {
                 completion(.failure(NetworkError.invalidResponse))
                 return
             }
             
             do {
                 let decoder = JSONDecoder()
                 let decodedData = try decoder.decode(T.self, from: responseData)
                 completion(.success(decodedData))
             } catch {
                 completion(.failure(error))
             }
         }
         
         task.resume()
     }
}
