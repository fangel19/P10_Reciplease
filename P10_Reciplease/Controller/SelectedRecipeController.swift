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
        
        detailRecipeView()
    }
    
//    func  detailRecipeView(withImage image: UIImage, name: String, ingredients: String) {
//
////        let chosen: RecipeDetail = self.recipeChosen[indexPath.row]
//        recipeNameLabel.text = recipeChosen.recipeName
//        allIngredients.text = recipeChosen.recipeIngredient
//        selectedRecipeImage.image = recipeChosen.recipeImage
//
//
//
//    }
    
    func  detailRecipeView() {

        recipeNameLabel.text = recipeChosen.recipeName
        allIngredients.text = recipeChosen.recipeIngredientList
        selectedRecipeImage.image = recipeChosen.recipeImage

    }
    
    @IBAction func favory(_ sender: Any) {
    }
    
    // Button for search recipe
    @IBAction func clicForDetailRecipe(_ sender: Any) {
        if let url = URL(string: "recipeChosen.url") {
            UIApplication.shared.open(url, options: [:])
        }
    }
//    
    //
    //    func selectedRecipe(_ sender: Any) {
    
    //        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecipeVC") as? RecipeController {
    //
    //            vc.ingredients = IngredientService.shared.ingredients
    //            navigationController?.pushViewController(vc, animated: true)
    //        }
    
    //            override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //                self.performSegueWithIdentifier("toDetailViewSegue", sender: self)
    //            }
    //
    //            override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //                let indexPath = tableView.indexPathForSelectedRow;
    //                let cellname = tableView.cellForRowAtIndexPath(indexPath!) as! CardTableViewCell;
    //                let DetailViewController = segue.destinationViewController
    //                DetailViewController.title = cellname.textLabel?.text
    //            }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //    }
}
