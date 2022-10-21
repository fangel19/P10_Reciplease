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
    
    //    MARK: - Singleton
    
    static let shared = RecipeRequest()
    
    // MARK: - Method
    
    func getRecipes(ingredients: [Ingredient], completion: @escaping ([Recipe]) -> Void) {
        
        AF.cancelAllRequests()
        
        let names: [String] = ingredients.map { $0.name }
        let formattedString: String = names.joined(separator: ",")
        
        guard let url = route.getURL(ingredients: formattedString)  else { return }
        
        
        AF.request(url, method: .get).responseDecodable(of: Welcome.self) { response in
            //Créer un tableau
            var recipes = [Recipe]()
            
            // Hydrater le tableau
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
                        recipeIngredient: hit.recipe.ingredientLines.joined(separator: ","),
                        recipeTemp: Double(hit.recipe.totalTime),
                        numberOfLikes: Double(hit.recipe.yield)
                    )
                    recipes.append(recipe)
                }
            }
            
            completion(recipes)
        }
    }
}
