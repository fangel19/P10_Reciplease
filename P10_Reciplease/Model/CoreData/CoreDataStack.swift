//
//  CoreDataStack.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 10/11/2022.
//

import Foundation
import UIKit
import CoreData

final class CoreDataStack {
    
    // MARK: - Properties
    //private let persistentContainerName = "Reciplease"
    
    //MARK: - Singleton
    
    static let sharedInstance = CoreDataStack()
    //    let sharedInstance = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - Public
    
    var viewContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
//        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    
    // MARK: - Private
    
    func retrieve(name: String) -> NSManagedObject?
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        fetchRequest.predicate = NSPredicate(format: "label LIKE %@", name)
        
        do {
            let entities = try viewContext.fetch(fetchRequest)
            return entities.first as? NSManagedObject
            //            for data in entities as! [NSManagedObject]
            
        } catch {
            return nil
        }
    }
    
    func save(recipe: Recipe) -> NSManagedObject?
    {
        let entity = NSEntityDescription.entity(forEntityName: "Recipe", in: viewContext)!
        let recipeEntity = NSManagedObject(entity: entity, insertInto: viewContext)
        recipeEntity.setValue(recipe.recipeName, forKey: "label")
        recipeEntity.setValue(recipe.ingredients.joined(separator: ";"), forKey: "ingredientLines")
        recipeEntity.setValue(recipe.recipeImage.pngData(), forKey: "image")
        recipeEntity.setValue(recipe.recipeDetailURL, forKey: "urlRecipe")
        recipeEntity.setValue(recipe.recipeTemp, forKey: "temp")
        recipeEntity.setValue(recipe.numberOfLikes, forKey: "likes")
        
        do {
            try viewContext.save()
            print("save")
            return recipeEntity
            
        }
        catch {
            return nil
        }
    }
    
    func deleteData(recipe: NSManagedObject) {
        //        let context = self.viewContext.managedObjectContext!
        viewContext.delete(recipe)
        do {
            try viewContext.save()
            print("delete")
        }
        catch {
        }
    }
    
    func getFavoryRecipes() -> [Recipe] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Recipe")
        do {
            let results: [NSManagedObject] = try viewContext.fetch(fetchRequest)
            var recipes: [Recipe] = []
            results.forEach { result in
                
                let imageData: Data? = result.value(forKey: "image") as? Data
                let image: UIImage? = imageData.flatMap { UIImage(data: $0) }
                
                let ingredients: String? = result.value(forKey: "ingredientLines") as? String
                let ingredientsArray: [String]? = ingredients?.components(separatedBy: ";")
                
                let recipe = Recipe(
                    recipeImage: image ?? UIImage(),
                    recipeName: result.value(forKey: "label") as! String,
                    ingredients: ingredientsArray ?? [],
                    recipeTemp: result.value(forKey: "temp") as! Double,
                    numberOfLikes: result.value(forKey: "likes") as! Double,
                    recipeDetailURL: result.value(forKey: "urlRecipe") as! String
                )
                
                recipes.append(recipe)
            }
            return recipes
        }
        catch {
            return []
        }
    }
}

