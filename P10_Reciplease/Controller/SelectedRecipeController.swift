//
//  SelectedRecipeController.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 14/10/2022.
//

import UIKit
import CoreData
import SwiftUI

class SelectedRecipeController: UIViewController {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var imageTextRecipeTableView: UITableView!
    @IBOutlet weak var selectedRecipeImage: UIImageView!
    @IBOutlet weak var allIngredients: UILabel!
    @IBOutlet weak var recipeDetailsButton: UIButton!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var favoriteRecipeButton: UIButton!
    @IBOutlet weak var gradientColorBlak: UIView!
    
    // MARK: - Properties
    
    var recipeChosen: Recipe!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hydrateView()
    }
    
    private var existingFavorite: NSManagedObject? = nil
    
    // Allows you to check if the recipe exists in the favorite and give it the right color
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        existingFavorite = CoreDataStack.sharedInstance.retrieve(name: recipeChosen.recipeName)
        
        if existingFavorite == nil {
            favoriteRecipeButton.tintColor = UIColor.gray
            
        } else {
            favoriteRecipeButton.tintColor = UIColor.yellow
        }
    }
    
    //MARK: - Function
    
    // View hydration
    private func  hydrateView() {
        gradientColorBlak.addBlackGradient(frame: gradientColorBlak.bounds, colors: [UIColor.clear, UIColor.black])
        recipeNameLabel.text = recipeChosen.recipeName
        allIngredients.text = recipeChosen.ingredients.joined(separator: "\n")
        selectedRecipeImage.downloaded(from: recipeChosen.recipeImage)
    }
    
    // To add or remove favorites
    @IBAction func favory(_ sender: UIButton) {
        if let favorite = existingFavorite {
            favoriteRecipeButton.tintColor = UIColor.gray
            CoreDataStack.sharedInstance.deleteData(recipe: favorite)
            existingFavorite = nil
            
        } else {
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
