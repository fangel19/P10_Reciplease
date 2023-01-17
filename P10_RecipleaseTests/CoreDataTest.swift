//
//  CoreDataTest.swift
//  P10_RecipleaseTests
//
//  Created by angelique fourny on 06/01/2023.
//

import XCTest
@testable import P10_Reciplease
import SwiftUI
import CoreData

class CoreDataTest: XCTestCase {
    
    //    // MARK: - Properties
    
    var coreDataStack: CoreDataStack!
    
    func recipeTest() -> Recipe {
        
        let imageSorbet: UIImage = {
            let imageSorbetURL =
       "https://avatars.githubusercontent.com/u/62841864?s=96&v=4"
            let imageUrl = URL(string: imageSorbetURL)
            let imageData = try! Data(contentsOf: imageUrl!)
            return UIImage(data: imageData as Data)!
        }()
        return Recipe(
            
            recipeImage: imageSorbet,
            recipeName: "Lemon Sorbet",
            ingredients: ["500.0g caster sugar",
                          "1 lemon , unwaxed, zested",
                          "250 ml lemon juice (6-8 lemons)"],
            recipeTemp: 0,
            numberOfLikes: 6.0,
            recipeDetailURL: "http://www.bbcgoodfood.com/recipes/4583/")
    }
    
    
    func recipeTest2() -> Recipe {
        let imageIceCream: UIImage = {
            let lemonIceCreamURL =
            "https://avatars.githubusercontent.com/u/62841864?s=96&v=4"
            let imageUrl = URL(string: lemonIceCreamURL)
            let imageData = try! Data(contentsOf: imageUrl!)
            return UIImage(data: imageData)!
        }()
        
        return Recipe(
            
            recipeImage: imageIceCream,
            recipeName: "Lemon Cookies",
            ingredients: ["Ingredients for basic butter cookies",
                          "2 tablespoons fresh lemon juice",
                          "1 tablespoon finely grated fresh lemon zest"],
            recipeTemp: 0.0,
            numberOfLikes: 48,
            recipeDetailURL: "https://www.epicurious.com/recipes/food/views/lemon-cookies-108920")
    }
    
    // MARK: - Tests
    
    func testaddAndRemoveRecipe() {
        let product1 = recipeTest()
        
        
        XCTAssertNil(coreDataStack?.retrieve(name: product1.recipeName))
                
        XCTAssertEqual(coreDataStack?.getFavoryRecipes().first?.recipeDetailURL, product1.recipeDetailURL)
        XCTAssertNotNil(coreDataStack.retrieve(name: product1.recipeName))
        
        let saved = coreDataStack.save(recipe: product1)
        coreDataStack.deleteData(recipe: saved!)
        
        XCTAssertEqual(coreDataStack.getFavoryRecipes().count, 0)
        XCTAssertNil(coreDataStack.retrieve(name: product1.recipeName))
    }
    
    
    func testAdd2RecipeToFavorite() {
        let product1 = recipeTest()
        let product2 = recipeTest2()
        
        XCTAssertNil(coreDataStack?.retrieve(name: product1.recipeName))
        XCTAssertNil(coreDataStack?.retrieve(name: product2.recipeName))
        
        coreDataStack.save(recipe: product1)
        coreDataStack.save(recipe: product2)
        let count1 = (coreDataStack.getFavoryRecipes().count)
        
        XCTAssertEqual(2, count1)
        XCTAssertEqual(coreDataStack.getFavoryRecipes().last?.recipeDetailURL, product1.recipeDetailURL)
        XCTAssertNotNil(coreDataStack.retrieve(name: product2.recipeName))
        XCTAssertNotNil(coreDataStack.retrieve(name: product1.recipeName))
        
    }
}
