//
//  SelectedRecipeController.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 14/10/2022.
//

import UIKit
import CoreData

class SelectedRecipeController: UIViewController {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var imageTextRecipeTableView: UITableView!
    @IBOutlet weak var selectedRecipeImage: UIImageView!
    @IBOutlet weak var allIngredients: UILabel!
    @IBOutlet weak var recipeDetailsButton: UIButton!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var favoriteRecipeButton: UIButton!
    
    // MARK: - Properties
    var recipeChosen: Recipe!

    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hydrateView()
        
    }
    
    private var existingFavorite: NSManagedObject? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        existingFavorite = CoreDataStack.sharedInstance.retrieve(name: recipeChosen.recipeName)
        // Expression ternaire
        //favoriteRecipeButton.tintColor = existingFavorite == nil ? UIColor.gray : UIColor.yellow
        if existingFavorite == nil
        {
            favoriteRecipeButton.tintColor = UIColor.gray
        }
        else
        {
            favoriteRecipeButton.tintColor = UIColor.yellow
        }
    }
    
    // View hydration
    func  hydrateView() {
        recipeNameLabel.text = recipeChosen.recipeName
        allIngredients.text = recipeChosen.ingredients.joined(separator: "\n")
        selectedRecipeImage.image = recipeChosen.recipeImage
    }
    
    @IBAction func favory(_ sender: UIButton) {
        if let favorite = existingFavorite
        
        {
            favoriteRecipeButton.tintColor = UIColor.gray
            CoreDataStack.sharedInstance.deleteData(recipe: favorite)
            existingFavorite = nil

        }
        else
        {
            favoriteRecipeButton.tintColor = UIColor.yellow
            existingFavorite = CoreDataStack.sharedInstance.save(recipe: recipeChosen)
            
        }
    }
    
    // Button for search recipe
    @IBAction func clicForDetailRecipe(_ sender: Any) {
        if let url = URL(string: recipeChosen.recipeDetailURL) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
