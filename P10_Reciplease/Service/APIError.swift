//
//  APIError.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 22/01/2023.
//

import Foundation

//MARK: Error handling

enum APIError: Error {
    
    case decoding
    case server
    case network
    case badURL
}
