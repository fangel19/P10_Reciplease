//
//  RecipeElement.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 04/10/2022.
//

// MARK: - RecipeElement
struct RecipeElement: Codable {
    let label: String
    let image: String
    let url: String
    let yield: Double
    let ingredientLines: [String]
    let ingredients: [IngredientRecipe]
    let totalTime: Double
}
