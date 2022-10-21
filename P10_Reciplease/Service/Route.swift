//
//  Route.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 02/12/2021.
//

import Foundation

final class Route {
    
    // MARK: - API Key and  API ID

    let apiKey = "c2809da35956f6fb80d5a86c46199b6b"
    let apiID = "e6b49d48"
//    let ingrediants = ""
    
    func getURL(ingredients: String) -> URL? {
        let urlAddress = "https://api.edamam.com/search?app_key=\(apiKey)&app_id=\(apiID)&q=\(ingredients)"
        
        guard let urlString = urlAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        return URL(string: urlString)
    }
    
}
