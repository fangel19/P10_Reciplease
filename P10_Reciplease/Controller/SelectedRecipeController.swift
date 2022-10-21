//
//  SelectedRecipeController.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 14/10/2022.
//

import UIKit

class SelectedRecipeController: UIViewController {
    
    
    @IBOutlet weak var selectedRecipeImage: UIImageView!
    @IBOutlet weak var selectedRecipeText: UITextView!
    @IBOutlet weak var recipeDetailsButton: UIButton!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var favoriteRecipeButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
//
//    func selectedRecipe(_ sender: Any) {
//
//        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecipeVC") as? RecipeController {
//
//            vc.ingredients = IngredientService.shared.ingredients
//            navigationController?.pushViewController(vc, animated: true)
//        }
        
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
