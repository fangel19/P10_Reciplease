//
//  RecipeTableViewCell.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 18/11/2021.
//

import UIKit
import SwiftUI

class RecipeTableViewCell: UITableViewCell {
    
    //Name of my identifier
    static let reusableIdentifier = "recipeCell"
    
    //MARK: - Outlets
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeIngredient: UILabel!
    @IBOutlet weak var numberOfLikes: UILabel!
    @IBOutlet weak var recipeTemp: UILabel!
    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var gradientView: UIView!
    
    // MARK: - LifeCycle
    private var gradientAdded: Bool = false
    override func layoutSubviews() {
        super.layoutSubviews()
        guard !gradientAdded else { return }
        DispatchQueue.main.async {
            self.gradientView.addBlackGradient(frame: self.gradientView.bounds, colors: [UIColor.clear, UIColor.black])
            self.gradientAdded = true
        }
    }
    
    //MARK: - Function
    
    // To configure the custom cell
    func configureCell(withImage imageUrl: String, name: String, ingredient: String,  like: Double, temp: Double) {
        
        recipeName.text = name
        recipeIngredient.text = ingredient
        recipeTemp.text = temp.recipeTempInt + (" ⏱")
        numberOfLikes.text = like.numberOfLikesInt + (" 👍")
        recipeImage.downloaded(from: imageUrl)
    }
}
