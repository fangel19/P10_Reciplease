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
    var selectedRecipe: Recipe? = nil
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ingredients)
        
        RecipeRequest.shared.getRecipes(ingredients: ingredients, completion: { results in

            self.recipes = results
            self.tableViewRecipe.reloadData()
        })
        
        tableViewRecipe.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "recipeCell")
        
        tableViewRecipe.delegate  = self
        tableViewRecipe.dataSource = self
    }
    
}

//MARK: - extention

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
        cell.configureCell(withImage: recipe.recipeImage, name: recipe.recipeName, ingredient: recipe.recipeIngredient, like: recipe.numberOfLikes, temp: recipe.recipeTemp)
//        cell.backgroundColor = .red
        
        
        return cell
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("toDetailViewSegue", sender: self)
//    }
//
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let indexPath = tableView.indexPathForSelectedRow;
//        let cellname = tableView.cellForRowAtIndexPath(indexPath!) as! CardTableViewCell;
//        let DetailViewController = segue.destinationViewController
//        DetailViewController.title = cellname.textLabel?.text
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected cell at index : \(indexPath.row)")
        selectedRecipe = self.recipes[indexPath.row]
        performSegue(withIdentifier: "toRecipeDetail", sender: nil)
    }
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecipeDetail" {
            let VCDestination = segue.destination as! SelectedRecipeController
            VCDestination.recipeChosen = selectedRecipe
        }
    }
//
    //    MARK: - Alert message
    
    private func alertMessage(title: String, message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

