//
//  RecipeController.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 18/11/2021.
//

import UIKit

class RecipeController: UIViewController {

    
    //MARK: - Outlets
    
    @IBOutlet weak var tableViewRecipe: UITableView!
    
    // MARK: - Properties

    var ingredients: [Ingredient] = IngredientService.shared.ingredients
    var recipes: [Recipe] = []
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ingredients)
        
//        RecipeRequest.shared.getRecipes(ingredients: ingredientsName.tableView, completion: { results in
        
        RecipeRequest.shared.getRecipes(ingredients: ingredients, completion: { results in
        
//            RecipeRequest.shared.getRecipes(ingredients: ingredients.endIndex ingredients[index(ofAccessibilityElement: Any)], completion: { results in
//        RecipeRequest.shared.getRecipes(ingredients: "Tomatoes", completion: { results in
            // Ici je reçois les résultats
            self.recipes = results
            self.tableViewRecipe.reloadData()
        })
        
        tableViewRecipe.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "recipeCell")
        
        tableViewRecipe.delegate  = self
        tableViewRecipe.dataSource = self
    }
//    
//    //    MARK: - Alert message
//    
//    private func alertMessage(title: String, message: String) {
//        
//        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        present(alertVC, animated: true, completion: nil)
//    }
}

//MARK: extention

// Recipe display in my tableview
extension RecipeController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableViewRecipe.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            
            return UITableViewCell()
        }
                
        let recipe: Recipe = self.recipes[indexPath.row]
        cell.configureCell(withImage: "", name: recipe.recipeName, ingredient: recipe.recipeIngredient, like: recipe.numberOfLikes, temp: recipe.recipeTemp)
        cell.backgroundColor = .red
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected cell at index : \(indexPath.row)")
        //performSegue
    }
}
