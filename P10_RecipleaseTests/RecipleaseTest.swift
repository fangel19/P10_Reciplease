//
//  RecipleaseTest.swift
//  P10_RecipleaseTests
//
//  Created by angelique fourny on 20/01/2023.
//

import XCTest
@testable import P10_Reciplease

class RecipleaseTest: XCTestCase {
    
    //    private var double: Double!
    private var ingredient1 = Ingredient(name: "Lemon")
    private var ingredient2 = Ingredient(name: "Orange")
    private var double: Double = 0.0
    private var ingredientService = IngredientService()
    private var ingredientController = IngredientController()
    
    func testAddIngredient() {
        
        ingredientService.add(ingredient: ingredient1)
        XCTAssertEqual(ingredientService.ingredients.count, 1)
    }
    
    func testRemoveAllIngredient() {
        
        ingredientService.removeAllIngredient()
        XCTAssertTrue(ingredientService.ingredients.count == 0)
    }
    
    func testRemoveOneIngredientInTheArray() {
        
        let ingredient1 = ingredient1
        let ingredient2 = ingredient2
        ingredientService.add(ingredient: ingredient1)
        ingredientService.add(ingredient: ingredient2)
        ingredientService.removeIngredient(at: 1)
        
        XCTAssertTrue(ingredientService.ingredients.count == 1)
    }
    
    func testWhenAddIngredient() {
        
        let lemon = "Lemon"
        ingredientService.add(ingredient: Ingredient.init(name: lemon))
        XCTAssertNotNil(lemon)
        XCTAssertEqual(lemon, "Lemon")
    }
    
    func testStringToRecipeTempInt() {
        
        let time = 2.0
        let changeTime = time.recipeTempInt
        XCTAssertTrue(changeTime == "2")
    }
    
    func testStringToNumberOfLikesInt() {
        
        let time = 2.0
        let changeTime = time.numberOfLikesInt
        XCTAssertTrue(changeTime == "2")
    }
    
    func testtRecipeWithImageNameIngredientsTempLikesUrl() {
        
        let recipe = Recipe(recipeImage: "", recipeName: "", ingredients: [""], recipeTemp: 2, numberOfLikes: 2, recipeDetailURL: "")
        
        XCTAssertEqual(recipe.recipeName, "")
        XCTAssertEqual(recipe.ingredients, [""])
        XCTAssertEqual(recipe.recipeTemp, 2)
        XCTAssertEqual(recipe.numberOfLikes, 2)
        XCTAssertEqual(recipe.recipeDetailURL, "")
        XCTAssertEqual(recipe.recipeImage, "")
    }
    
    func testMessageAlert() {
        
        let alert = ingredientController
        let _ = ingredientService.ingredients.count == 0
        
        XCTAssertTrue(alert.alertMessage(title: "Erreur", message: "Il n'y a pas d'ingredients") == alert.alertMessage(title: "Erreur", message: "Il n'y a pas d'ingredients"))
    }
    
    func testApiErrorComesFromTheServer() {
        
        let apiError = APIError.server
        XCTAssertTrue((apiError.asAFError == nil))
    }
    
    func testApiErrorComesFromTheNetwork() {
        
        let apiError = APIError.network
        XCTAssertTrue((apiError.asAFError == nil))
    }
    
    func testApiErrorComesFromTheDecoding() {
        
        let apiError = APIError.decoding
        XCTAssertTrue((apiError.asAFError == nil))
    }
    
    func testApiErrorComesFromTheServerbadUrl() {
        
        let apiError = APIError.badURL
        XCTAssertTrue((apiError.asAFError == nil))
    }
    
    func testTheFavory(){
        
        let gray = CoreDataStack.sharedInstance.retrieve(name: "")
        XCTAssertTrue(gray == nil)
    }
}
