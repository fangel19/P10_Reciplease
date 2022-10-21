//
//  RecipeTableViewCell.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 18/11/2021.
//

import UIKit

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
    
// MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
        
    func configureCell(withImage image: String, name: String, ingredient: String,  like: Double, temp: Double) {
        
        recipeName.text = name
        recipeIngredient.text = ingredient
        recipeTemp.text = temp.recipeTempInt
        numberOfLikes.text = like.numberOfLikesInt
        recipeImage.image = UIImage.init(named: image)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
