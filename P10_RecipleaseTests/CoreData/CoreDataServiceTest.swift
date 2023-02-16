//
//  CoreDataServiceTest.swift
//  P10_RecipleaseTests
//
//  Created by angelique fourny on 28/01/2023.
//

import XCTest
@testable import P10_Reciplease
import SwiftUI
import CoreData

class CoreDataServiceTest: XCTestCase {
    
    var coreDataService: CoreDataService!
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestContext()
        coreDataService = CoreDataService(coreDataStack: coreDataStack)
    }
    
    let recipeTest = Recipe(
        recipeImage: "https://avatars.githubusercontent.com/u/62841864?s=96&v=4",
        recipeName: "Lemon Sorbet",
        ingredients: ["500.0g caster sugar",
                      "1 lemon , unwaxed, zested",
                      "250 ml lemon juice (6-8 lemons)"],
        recipeTemp: 0,
        numberOfLikes: 6.0,
        recipeDetailURL: "http://www.bbcgoodfood.com/recipes/4583/")
    
    let recipeTest2 = Recipe(
        recipeImage: "https://avatars.githubusercontent.com/u/62841864?s=96&v=4",
        recipeName: "Lemon Cookies",
        ingredients: ["Ingredients for basic butter cookies",
                      "2 tablespoons fresh lemon juice",
                      "1 tablespoon finely grated fresh lemon zest"],
        recipeTemp: 0,
        numberOfLikes: 48,
        recipeDetailURL: "https://www.epicurious.com/recipes/food/views/lemon-cookies-108920")
    
    private var recipeList = [RecipeMO]()
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        coreDataService = nil
    }
    
    func testAddRecipe() {
        
        let savedRecipe = coreDataService.save(recipe: recipeTest)
        
        XCTAssertNotNil(savedRecipe)
        XCTAssertEqual(savedRecipe?.image,"https://avatars.githubusercontent.com/u/62841864?s=96&v=4")
        XCTAssertEqual(savedRecipe?.label,"Lemon Sorbet")
        XCTAssertEqual(savedRecipe?.ingredientLines!,"500.0g caster sugar;1 lemon , unwaxed, zested;250 ml lemon juice (6-8 lemons)")
        XCTAssertEqual(savedRecipe?.temp,0)
        XCTAssertEqual(savedRecipe?.likes,6.0)
        XCTAssertEqual(savedRecipe?.urlRecipe,"http://www.bbcgoodfood.com/recipes/4583/")
        coreDataStack.deleteData(recipe: savedRecipe!)
    }
    
    func testAddTwoRecipe() {
        
        let savedRecipe1 = coreDataService.save(recipe: recipeTest)
        let savedRecipe2 = coreDataService.save(recipe: recipeTest2)
        
        XCTAssertNotNil(savedRecipe1)
        XCTAssertNotNil(savedRecipe2)
        coreDataService.deleteData(recipe: savedRecipe1!)
        coreDataService.deleteData(recipe: savedRecipe2!)
        
        print("=> COUNT", coreDataService.getFavoryRecipes().count)
    }
    
    func testAddAndDeleteRecipe() {
        
        let savedRecipe1 = coreDataService.save(recipe: recipeTest)
        
        XCTAssertNotNil(savedRecipe1)
        coreDataService.deleteData(recipe: savedRecipe1!)
        XCTAssertEqual(coreDataService.getFavoryRecipes().count, 0)
    }
    
    func testRetriveAndGetFavoryRecipe() {
        
        let savedRecipe = coreDataService.save(recipe: recipeTest)
        
        XCTAssertNotNil(savedRecipe)
        XCTAssertEqual(coreDataService.getFavoryRecipes().first?.recipeDetailURL, recipeTest.recipeDetailURL)
        
        print("=>", coreDataService.getFavoryRecipes().count)
        coreDataService.deleteData(recipe: savedRecipe!)
        XCTAssertEqual(coreDataService.getFavoryRecipes().count, 0)
    }
    
    func testRetriveRecipe() {
        
        let savedRecipe = coreDataService.save(recipe: recipeTest)
        
        XCTAssertNotNil(savedRecipe)
        XCTAssertNotNil(coreDataService.retrieve(name: "Lemon Sorbet"))
        XCTAssertNotNil(coreDataStack.retrieve(name: recipeTest.recipeName))
        coreDataService.deleteData(recipe: savedRecipe!)
    }
    
    func testGetFavoryRecipesUrl() {
        
        let savedRecipe = coreDataService.save(recipe: recipeTest)
        
        XCTAssertNotNil(savedRecipe)
        XCTAssertEqual(savedRecipe?.label, coreDataService.getFavoryRecipes().first?.recipeName)
        coreDataStack.deleteData(recipe: savedRecipe!)
    }
    
    func testProblemWithRetrieve() {
        
        let retrievedRecipe = coreDataService.retrieve(name: "TOTO")
        XCTAssertNil(retrievedRecipe)
    }
}
