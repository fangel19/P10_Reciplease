//
//  IngredientService.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 10/11/2021.
//

import Foundation

class IngredientService {
    
    
    // MARK: - Singleton
    
    static let shared = IngredientService()
    private  init() {}
    
    // MARK: - Properties
    
    private(set) var ingredients: [Ingredient] = []
    
    //MARK: - Function
    
    // For append ingredient
    func add(ingredient: Ingredient) {
        ingredients.append(ingredient)
    }
    
    // For remove just one ingredient
    func removeIngredient(at index: Int)  {
        ingredients.remove(at: index)
    }
    
    // F>or remove all ingredients
    func removeAllIngredient() {
        ingredients.removeAll()
    }
}
