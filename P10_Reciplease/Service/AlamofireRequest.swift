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
    func getRecipes(ingredients: [Ingredient], completion: @escaping ([Recipe], Error?) -> Void) {
        
        AF.cancelAllRequests()
        
        let names: [String] = ingredients.map { $0.name }
        let formattedString: String = names.joined(separator: ",")
        
        guard let url = route.getURL(ingredients: formattedString)  else { return }
        
        session.request(url, method: .get).responseDecodable(of: Welcome.self) { response in
            //Create an array
            var recipes = [Recipe]()
            
            // Hydrate the array
            let welcome = response.value
            welcome?.hits.forEach { hit in
                let urlString: String = hit.recipe.image
                if let url: URL = URL(string: urlString)
                    , let data: Data = try? Data(contentsOf: url)
                    , let image: UIImage = UIImage(data: data)
                    
                {
                    let recipe = Recipe(
                        recipeImage: image,
                        recipeName: hit.recipe.label,
                        ingredients: hit.recipe.ingredientLines,
                        recipeTemp: Double(hit.recipe.totalTime),
                        numberOfLikes: Double(hit.recipe.yield),
                        recipeDetailURL: hit.recipe.url)
                    
                    recipes.append(recipe)
                }
            }
            completion(recipes, response.error)
        }
    }
}
