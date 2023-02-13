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
    
    private var favorites: [Recipe] = []
    private var selectedRecipe: Recipe? = nil
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRecipe()
        tableViewFavorite.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "recipeCell")
        tableViewFavorite.delegate  = self
        tableViewFavorite.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRecipe()
    }
    
    // Allows you to update the favorites view as soon as you open it
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
    
    // To identify the custom cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected cell at index : \(indexPath.row)")
        selectedRecipe = self.favorites[indexPath.row]
        performSegue(withIdentifier: "toRecipeDetailFavory", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113
    }
    
    //Show custom cell in this view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecipeDetailFavory" {
            let VCDestination = segue.destination as! SelectedRecipeController
            VCDestination.recipeChosen = selectedRecipe
        }
    }
}
