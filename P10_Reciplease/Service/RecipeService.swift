//
//  RecipeService.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 17/11/2021.
//

import Foundation

class RecipeService {
    
    static let shared = RecipeService()
    private  init() {}
    
    private(set) var recipes: [Recipe] = []
    
    func add(recipe: Recipe) {
        
        recipes.append(recipe)
    }
}
