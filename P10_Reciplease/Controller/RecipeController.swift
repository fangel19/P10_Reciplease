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
    private var recipes: [Recipe] = []
    private var selectedRecipe: Recipe? = nil
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loader = loader()
        
        RecipeRequest.shared.getRecipes(ingredients: ingredients, completion: { results, error in
            
            self.recipes = results
            self.tableViewRecipe.reloadData()
            
            self.stopLoader(loader: loader, completion: {
                if results.isEmpty {
                    self.alertMessage(title: "error", message: "There is no recipe with this ingredient check your ingredients")
                }
                else if let error = error
                {
                    self.alertMessage(title: "error", message: error.localizedDescription)
                }
            })
        })
        
        tableViewRecipe.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "recipeCell")
        
        tableViewRecipe.delegate  = self
        tableViewRecipe.dataSource = self
    }
    
    //MARK: - Function
    
    // Loader with message
    private func loader() -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: "Please wait", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(style: .large)
        
        indicator.center = CGPoint(x: 140, y: 100)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        alert.view.addSubview(indicator)
        present(alert, animated: true, completion: nil)
        
        return alert
    }
    
    // Loader stop
    private func stopLoader(loader: UIAlertController, completion: @escaping () -> Void = {}) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: completion)
        }
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
        cell.configureCell(withImage: recipe.recipeImage, name: recipe.recipeName, ingredient: recipe.ingredients.joined(separator: ", "), like: recipe.numberOfLikes, temp: recipe.recipeTemp)
        
        return cell
    }
    
    // To identify the custom cell
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected cell at index : \(indexPath.row)")
        selectedRecipe = self.recipes[indexPath.row]
        performSegue(withIdentifier: "toRecipeDetail", sender: nil)
    }
    
    //Show custom cell in this view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecipeDetail" {
            let VCDestination = segue.destination as! SelectedRecipeController
            VCDestination.recipeChosen = selectedRecipe
        }
    }
}

