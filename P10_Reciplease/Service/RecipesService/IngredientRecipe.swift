//
//  IngredientRecipe.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 04/10/2022.
//

// MARK: - IngredientRecipe
struct IngredientRecipe: Codable {
    let text: String
    let quantity: Double
    let measure: String?
    let food: String
    let weight: Double
    let foodCategory, foodId: String?
    let image: String
}
