//
//  RecipeElement.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 04/10/2022.
//

// MARK: - RecipeElement
struct RecipeElement: Codable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url, shareAs: String
    let yield: Double
    let ingredientLines: [String]
    let ingredients: [IngredientRecipe]
    let calories, totalWeight: Double
    let totalTime: Int
    let cuisineType: [String]
}
