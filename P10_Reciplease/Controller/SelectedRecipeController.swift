//
//  SelectedRecipeController.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 14/10/2022.
//

import UIKit

class SelectedRecipeController: UIViewController {
    
    
    @IBOutlet weak var imageTextRecipeTableView: UITableView!
    @IBOutlet weak var selectedRecipeImage: UIImageView!
    @IBOutlet weak var allIngredients: UILabel!
    @IBOutlet weak var recipeDetailsButton: UIButton!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var favoriteRecipeButton: UIButton!
    
//    var titleName: String = ""
    var recipeChosen: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hydrateView()
    }
    
    func  hydrateView() {

        recipeNameLabel.text = recipeChosen.recipeName
        allIngredients.text = recipeChosen.ingredients.joined(separator: "\n")
        selectedRecipeImage.image = recipeChosen.recipeImage
    }
    
    @IBAction func favory(_ sender: AnyObject) {
        
    }
    
    // Button for search recipe
    @IBAction func clicForDetailRecipe(_ sender: Any) {
        if let url = URL(string: recipeChosen.recipeDetailURL) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
