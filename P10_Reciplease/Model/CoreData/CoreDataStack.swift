//
//  CoreDataStack.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 10/11/2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataStack {
    
    // MARK: - Singleton
    
    static let sharedInstance = CoreDataStack()
    
    // MARK: - Public
    
    public var viewContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Methods
    
    // Retrieve the recipe in Core data
    public func retrieve(name: String) -> RecipeMO? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        fetchRequest.predicate = NSPredicate(format: "label LIKE %@", name)
        
        do {
            let entities = try viewContext.fetch(fetchRequest)
            return entities.first as? RecipeMO
            
        } catch {
            return nil
        }
    }
    
    // For save recipe
    public func save(recipe: Recipe) -> RecipeMO? {
        
        let recipeEntity = RecipeMO(context: viewContext)
        recipeEntity.setValue(recipe.recipeName, forKey: "label")
        recipeEntity.setValue(recipe.ingredients.joined(separator: ";"), forKey: "ingredientLines")
        recipeEntity.setValue(recipe.recipeImage, forKey: "image")
        recipeEntity.setValue(recipe.recipeDetailURL, forKey: "urlRecipe")
        recipeEntity.setValue(recipe.recipeTemp, forKey: "temp")
        recipeEntity.setValue(recipe.numberOfLikes, forKey: "likes")
        
        do {
            try viewContext.save()
            print("save")
            return recipeEntity
            
        } catch {
            return nil
        }
    }
    
    // for delete recipe
    public func deleteData(recipe: RecipeMO) {
        viewContext.delete(recipe)
        do {
            try viewContext.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // get favorite recipes that will be used to display views
    public func getFavoryRecipes() -> [Recipe] {
        
        let fetchRequest = RecipeMO.fetchRequest()
        do {
            let results = try viewContext.fetch(fetchRequest)
            var recipes: [Recipe] = []
            results.forEach { result in
                
                let ingredients: String? = result.value(forKey: "ingredientLines") as? String
                let ingredientsArray: [String]? = ingredients?.components(separatedBy: ";")
                
                let recipe = Recipe(
                    recipeImage: result.value(forKey: "image") as! String,
                    recipeName: result.value(forKey: "label") as! String,
                    ingredients: ingredientsArray ?? [],
                    recipeTemp: result.value(forKey: "temp") as! Double,
                    numberOfLikes: result.value(forKey: "likes") as! Double,
                    recipeDetailURL: result.value(forKey: "urlRecipe") as! String
                )
                recipes.append(recipe)
            }
            return recipes
            
        } catch {
            return []
        }
    }
}

