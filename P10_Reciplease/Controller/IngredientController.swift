//
//  IngredientController.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 10/11/2021.
//

import UIKit
import Alamofire

class IngredientController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameIngredientTextField: UITextField!
    @IBOutlet weak var searchRecipesButton: UIButton!
    @IBOutlet weak var addIngredient: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     }
    
    //MARK: - @IBACTION
    
    // Add button to add ingredients in tableView
    @IBAction func tappedAddIngredient(_ sender: Any) {
        
        guard let name = nameIngredientTextField.text else { return }
        
        let ingredient = Ingredient(name: name)
        IngredientService.shared.add(ingredient: ingredient)
        tableView?.reloadData()
    }
        
    // Button for remove ingredients in tableView
    @IBAction func clearButton(_ sender: Any) {
        
        IngredientService.shared.removeAllIngredient()
        tableView.reloadData()
    }
    
    // Button for search recipe
    @IBAction func searchRecipeButton(_ sender: Any) {
        
        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecipeVC") as? RecipeController {
            
            vc.ingredients = IngredientService.shared.ingredients
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - Extension

extension IngredientController: UITextFieldDelegate,
                                UITableViewDataSource {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    // Ingredient display in my tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IngredientService.shared.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        let ingredient = IngredientService.shared.ingredients[indexPath.row]
        cell.textLabel?.text = ingredient.name
        return cell
    }
}

// editing style for delete in the tableview
extension IngredientController:  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            IngredientService.shared.removeIngredient(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
