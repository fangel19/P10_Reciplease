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
    
    var favorites: [RecipeMO] = []
    //    var favory = SelectedRecipeController()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request: NSFetchRequest<RecipeMO> = RecipeMO.fetchRequest()
        guard let recipeMO = try? CoreDataStack.sharedInstance.viewContext.fetch(request) else { return }
        
        var completeRecipe = ""
        for recipe in recipeMO {
            if let name = recipe.label{
                completeRecipe += name
            }
        }
        
        //        RecipeRequest.shared.getRecipes(ingredients: ingredients, completion: { results in
        //
        //            self.recipes = results
        //            self.tableViewRecipe.reloadData()
        //        })
        //
        //        tableViewRecipe.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "recipeCell")
        //
        //        tableViewRecipe.delegate  = self
        //        tableViewRecipe.dataSource = self
        //    }
        //}
        
        //
        //        let appDelegate = UIApplication.shared.delegate as! AppDelegate else {
        //                return
        //            }
        //
        //        let managedContext =
        //            appDelegate.persistentContainer.viewContext
        //
        //
        //        let fetchRequest =
        //          NSFetchRequest<NSManagedObject>(entityName: "Person")
        //
        //        //3
        //        do {
        //          favorites = try managedContext.fetch(fetchRequest)
        //        } catch let error as NSError {
        //          print("Could not fetch. \(error), \(error.userInfo)")
        //        }
    }
    
    //
    //        recipeMO = results
    //        tableViewFavorite.reloadData()
    //        //        RecipeMO.shared.getRecipes(ingredients: ingredients, completion: { results in
    //        //
    //        //            self.recipes = results
    //        //            self.tableViewRecipe.reloadData()
    //    }
    //
    //        tableViewFavorite.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "recipeCell")
    //
    //    tableViewFavorite.delegate  = self
    //    tableViewFavorite.dataSource = self
    //}
    
    // Do any additional setup after loading the view.
    //        tableViewFavorite.delegate  = self
    //        tableViewFavorite.dataSource = self
    
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
        
        return UITableViewCell()
        
        //        let favory: RecipeMO = self.favorites[indexPath.row]
        //        cell.configureCell(withImage: favory.image, name: favory.label, ingredient: favory.ingredientLines.joined(separator: ", "), like: favory.numberOfLikes, temp: favory.recipeTemp)
        //        cell.backgroundColor = .red
        
        //
        //        return cell
        //    }
        //}
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
    }
    //
    //for favory in recipeMO {
    //    if let name = favory.label,
    //       let ingredient = favory.ingredientLines,
    //       let image = favory.image,
    //       let likes = favory.likes,
    //       let temp = favory.temp,
    //       let url = favory.urlRecipe {
    //
}
