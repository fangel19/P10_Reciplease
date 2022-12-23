//
//  FavoriteRecipeController.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 10/11/2022.
//

import UIKit
import CoreData

class FavoriteRecipeController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableViewFavorite: UITableView!
    
    // MARK: - Properties
    
    //    let request: NSFetchRequest<RecipeMO> = RecipeMO.fetchRequest()
    
//    var ingredients: [Ingredient] = IngredientService.shared.ingredients
    
    var favorites: [Recipe] = []
    var selectedRecipe: Recipe? = nil
    //    var favory = SelectedRecipeController()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        CoreDataStack.sharedInstance.getFavoryRecipes()
        //        RecipeRequest.shared.getRecipes(ingredients: ingredients, completion: { results in
        //
        //            self.favorites = results
        //            self.tableViewFavorite.reloadData()
        //        })
        
        fetchRecipe()
        
        tableViewFavorite.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "recipeCell")
        
        tableViewFavorite.delegate  = self
        tableViewFavorite.dataSource = self
        
        
        //        guard let recipeMO = try? CoreDataStack.sharedInstance.viewContext.fetch(request) else { return }
        //
        //        var completeRecipe = ""
        //        for recipe in recipeMO {
        //            if let name = recipe.label{
        //                completeRecipe += name
        //            }
        //        }
        
    }

    func fetchRecipe() {
        let recipes: [Recipe] = CoreDataStack.sharedInstance.getFavoryRecipes()
        self.favorites = recipes
        tableViewFavorite.reloadData()
    }
    
}
//MARK: - extention

// Recipe display in my tableview
extension FavoriteRecipeController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableViewFavorite.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            
            return UITableViewCell()
        }
        
        let favory: Recipe = self.favorites[indexPath.row]
        
        cell.configureCell(withImage: favory.recipeImage, name: favory.recipeName, ingredient: favory.ingredients.joined(separator: ", "), like: favory.numberOfLikes, temp: favory.recipeTemp)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected cell at index : \(indexPath.row)")
        selectedRecipe = self.favorites[indexPath.row]
        performSegue(withIdentifier: "toRecipeDetailFavory", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecipeDetailFavory" {
            let VCDestination = segue.destination as! SelectedRecipeController
            VCDestination.recipeChosen = selectedRecipe
        }
    }
    //
    //override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    //        switch editingStyle {
    //        case .Delete:
    //            //remove the deleted item from the model
    //            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    //            let context:NSManagedObjectContext = appDel.managedObjectContext!
    //            context.deleteObject(favorites[indexPath.row] as NSManagedObject)
    //            favorites.removeAtIndex(indexPath.row)
    //            context.save(nil)
    //
    //           //tableView.reloadData()
    //            //remove the deleted item from the `UITableView`
    //            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    //        default:
    //            return
    //
    //        }
    //}
    
}
