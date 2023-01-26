//
//  AlamofireRequest.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 02/12/2021.
//

import Foundation
import Alamofire


class RecipeRequest {
    
    private let route = Route()
    private let session: Alamofire.Session
    
    //    MARK: - Singleton
    static let shared = RecipeRequest(session: Alamofire.Session(configuration: .default))
    
    init(session: Alamofire.Session) {
        self.session = session
    }
    
    // MARK: - Method
    
    // For get recipes through its url
    func getRecipes(ingredients: [Ingredient], completion: @escaping (Result<Welcome, APIError>) -> Void) {
        
        AF.cancelAllRequests()
        
        let names: [String] = ingredients.map { $0.name }
        let formattedString: String = names.joined(separator: ",")
        
        guard let url = route.getURL(ingredients: formattedString)  else {
            completion(.failure(.badURL))
            return
        }
        
        
        session.request(url).validate(statusCode: 200..<299).responseData { response in
            
            switch response.result {
            case .success(let hits):
                print(hits.count)
                
                guard let recipes = try? JSONDecoder().decode(Welcome.self, from: hits) else {
                    completion(.failure(.decoding))
                    return
                }
                completion(.success(recipes))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
