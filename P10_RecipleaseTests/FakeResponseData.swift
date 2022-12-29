//
//  FakeResponseData.swift
//  P10_RecipleaseTests
//
//  Created by angelique fourny on 23/12/2022.
//

import Foundation

class FakeResponseData {
    
    // MARK: - Response
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
   
    
    // MARK: - Data
    
    static var recipeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let IncorrectData = "erreur" .data(using: .utf8)!
    
    // MARK: - Error
         
     class ConversionError: Error {}
     
     static let conversionError = ConversionError()
}
