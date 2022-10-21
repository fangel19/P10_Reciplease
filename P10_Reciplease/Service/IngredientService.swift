//
//  IngredientService.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 10/11/2021.
//

import Foundation

class IngredientService {
    
    static let shared = IngredientService()
    private  init() {}
    
    private(set) var ingredients: [Ingredient] = []
    
    func add(ingredient: Ingredient) {
        
        ingredients.append(ingredient)
    }
    
    func removeIngredient(at index: Int)  {
        ingredients.remove(at: index)
    }
    
    func removeAllIngredient() {
        ingredients.removeAll()
    }
    
}
