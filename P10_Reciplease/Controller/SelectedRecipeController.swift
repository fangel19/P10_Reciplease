//
//  SelectedRecipeController.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 14/10/2022.
//

import UIKit

class SelectedRecipeController: UIViewController {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var imageTextRecipeTableView: UITableView!
    @IBOutlet weak var selectedRecipeImage: UIImageView!
    @IBOutlet weak var allIngredients: UILabel!
    @IBOutlet weak var recipeDetailsButton: UIButton!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var favoriteRecipeButton: UIButton!
    
    // MARK: - Properties
    
    //    var titleName: String = ""
    var recipeChosen: Recipe!
    var recipe: RecipeMO!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hydrateView()
        
    }
    
    // View hydration
    func  hydrateView() {
        recipeNameLabel.text = recipeChosen.recipeName
        allIngredients.text = recipeChosen.ingredients.joined(separator: "\n")
        selectedRecipeImage.image = recipeChosen.recipeImage
    }
    
    // Button star for favorite
    @IBAction func favory(_ sender: UIButton) {
        
        if sender.isSelected{
            favoriteRecipeButton.tintColor = UIColor.yellow
            CoreDataStack.sharedInstance.save(recipe: recipeChosen)
            
        }
        else{
            favoriteRecipeButton.tintColor = UIColor.gray
            CoreDataStack.sharedInstance.delete(recipe: recipeChosen)
        }
    }
    
    
    //
    //        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecipeVC") as? RecipeController {
    //
    //            vc.ingredients = IngredientService.shared.ingredients
    //            navigationController?.pushViewController(vc, animated: true)
    //        }
    
    
    
    // Button for search recipe
    @IBAction func clicForDetailRecipe(_ sender: Any) {
        if let url = URL(string: recipeChosen.recipeDetailURL) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
