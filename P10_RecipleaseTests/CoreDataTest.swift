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
    
    let recipeTest: Recipe = {
        
        let imageSorbet: UIImage = {
            let imageSorbetURL = "http://cdn.playbuzz.com/cdn/38402fff-32a3-4e78-a532-41f3a54d04b9/cc513a85-8765-48a5-8481-98740cc6ccdc.jpg"
            let imageUrl = URL(string: imageSorbetURL)!
            let imageData = try! Data(contentsOf: imageUrl)
            return UIImage(data: imageData)!
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
        
    }()
    
    let recipeTest2: Recipe = {
        
        let imageIcey: UIImage = {
            let lemonIceyURL = "http://cdn.playbuzz.com/cdn/38402fff-32a3-4e78-a532-41f3a54d04b9/cc513a85-8765-48a5-8481-98740cc6ccdc.jpg"
            let imageUrl = URL(string: lemonIceyURL)!
            let imageData = try! Data(contentsOf: imageUrl)
            return UIImage(data: imageData)!
        }()
        
        return Recipe(
            
            recipeImage: imageIcey,
            recipeName: "Lemon Icey",
            ingredients: ["1 cup lemon juice (from 5-6 lemons)", "1 cup simple syrup"],
            recipeTemp: 1,
            numberOfLikes: 7.0,
            recipeDetailURL: "https://www.marthastewart.com/868405/lemon-icey")
    }()
    
    // MARK: - Tests
    
    func testaddAndRemoveRecipe() {
        let product1 = recipeTest

        
        XCTAssertNil(coreDataStack?.retrieve(name: product1.recipeName))
        
        coreDataStack?.save(recipe: product1)
        
        XCTAssertEqual(coreDataStack?.getFavoryRecipes().first?.recipeDetailURL, product1.recipeDetailURL)
        XCTAssertNotNil(coreDataStack.retrieve(name: product1.recipeName))
        
        let saved = coreDataStack.save(recipe: product1)
        coreDataStack.deleteData(recipe: saved!)
        
        coreDataStack.deleteData(recipe: coreDataStack.save(recipe: product1)!)
                  
//        let entity = { [self] in
//            NSEntityDescription.entity(forEntityName: "Recipe", in: self.coreDataStack.viewContext)
//            var recipeEntity = NSManagedObject(context: self.coreDataStack.viewContext)
//            recipeEntity.setValue(product1.recipeName, forKey: "label")
//            coreDataStack.deleteData(recipe: recipeEntity)
//
//
//        }
//
        XCTAssertEqual(coreDataStack.getFavoryRecipes().count, 0)
        XCTAssertNil(coreDataStack.retrieve(name: product1.recipeName))
    }
    
    
    func testAdd2RecipeToFavorite() {
        let product1 = recipeTest
        let product2 = recipeTest2
        
        XCTAssertNil(coreDataStack.retrieve(name: product1.recipeName))
        XCTAssertNil(coreDataStack.retrieve(name: product2.recipeName))
        
        coreDataStack.save(recipe: product1)
        coreDataStack.save(recipe: product2)
        let count1 = coreDataStack.getFavoryRecipes().count
        
        XCTAssertEqual(2, count1)
        XCTAssertEqual(coreDataStack.getFavoryRecipes().last?.recipeName, product1.recipeName)
        XCTAssertNotNil(coreDataStack.retrieve(name: product2.recipeName))
        XCTAssertNotNil(coreDataStack.retrieve(name: product1.recipeName))
    }
}
