//
//  CoreDataStack.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 10/11/2022.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    // MARK: - Properties
    
    private let persistentContainerName = "Reciplease"
    var favorites: [RecipeMO] = []
    
    //MARK: - Singleton
    
    static let sharedInstance = CoreDataStack()
    
    // MARK: - Public
    
    var viewContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    
    // MARK: - Private
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo) for: \(storeDescription.description)")
            }
        })
        return container
    }()
    
    func save(recipe: Recipe)
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
            print("sauvegarder")
            
        }
        catch {
            print("Il y a eu une erreur d'enregistrement")
        }
    }
    
    func delete(recipe: Recipe) {
        favorites.removeAll()
        do {
            try viewContext.save()
            print("supprimer")
            
        }
        catch {
            print("Il y a eu une erreur de suppression")
        }
        
    }
    
    //    func deleteArticle (withId recipeID:UUID) {
    //        if let indexRecipe = favorites.firstIndex(where: { (article) -> Bool in
    //            article.id == recipeID
    //        }) {
    //            print ("ListManagement.deleteArticle id=\(recipeID) indexArticle=\(indexRecipe)")
    //            print ("deleteArticle \(favorites [indexRecipe]."articleName")")
    //            favorites.remove (at: indexRecipe)
    //            viewContext.deleteArticle(withId: recipeID)
    //        }
    //        else {
    //            print ("ListManagement.deleteArticle id=\(articleId) not found")
    //        }
    //    }
    
//    func retrieve() -> [Recipe] {
//
//        //        let request: NSFetchRequest<RecipeMO> = RecipeMO.fetchRequest()
//        //        guard let recipeMO = try? CoreDataStack.sharedInstance.viewContext.fetch(request) else { return }
//        //
//        //        var completeRecipe = ""
//        //        for recipe in recipeMO {
//        //            if let name = recipe.label{
//        //                completeRecipe += name
//        //            }
//
//
//
//        let request = NSFetchRequest<NSManagedObject>(entityName: "RecipeMO")
//
//        do {
//            try? viewContext.fetch(request)
//            //            favorites = try viewContext.fetch(request)
//        }  catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//
//    }
    
    
    // Créer une nouvelle requête fetch en utilisant l'entité RecipeMO
    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeMO")
    
    // Exécuter la requête fetch et ranger les résultats dans un tableau d'objets  LogItem
    //        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [RecipeMO] {
    //
    //            // Créer une alerte et définir son message
    //            let alert = UIAlertController(title: fetchResults[0].title,
    //                                          message: fetchResults[0].itemText,
    //                                          preferredStyle: .Alert)
    //
    //            // Afficher l'alerte
    //            self.presentViewController(alert,
    //                                       animated: true,
    //                                       completion: nil)
    //        }
    //    }
    
    
    //        let request: NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeMO")
    //        request.returnsObjectsAsFaults = false
    //
    //        do {
    //            let results = try viewContext.fetch(request)
    //
    //            if results.count > 0 {
    //                for r is results as! [NSManagedObject] {
    //                    if let nameLabel = r.value(forKey: "Label") as! String {
    //                        print(nameLabel)
    //                    }
    //                }
    //            }
    //        } catch {
    //
    //        }
    
    
    
    //private func saveFavory(name: String, ingredients: String, image: UIImage, numberOfLikes: Double, temp: Double, URL: String) {
    //    let favory = RecipeMO(context: CoreDataStack.sharedInstance.viewContext)
    //    favory.label = name
    //    favory.ingredientLines = ingredients
    //    favory.image = image
    //    favory.urlRecipe = URL
    //    favory.temp = temp
    //    favory.likes = numberOfLikes
    //
    //    do {
    //        try CoreDataStack.sharedInstance.viewContext.save()
    //    } catch {
    //        print("We were unable to save \(favory)")
    //    }
    //}*/
}
