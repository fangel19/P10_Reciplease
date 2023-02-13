//
//  CoreDataService.swift
//  P10_RecipleaseTests
//
//  Created by angelique fourny on 28/01/2023.
//

import Foundation
import CoreData
@testable import P10_Reciplease


class CoreDataService {
    
    
    private let coreDataStack: TestContext
    private let viewContextManaged: NSManagedObjectContext
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack as! TestContext
        self.viewContextManaged = coreDataStack.viewContext }
    
    // MARK: - Methods
    // Retrieve the recipe in Core data
    public func retrieve(name: String) -> RecipeMO? {
        coreDataStack.retrieve(name: name)
    }
    
    // For save recipe
    public func save(recipe: Recipe) -> RecipeMO? {
        return coreDataStack.save(recipe: recipe)
    }
    
    // for delete recipe
    public func deleteData(recipe: RecipeMO) {
        coreDataStack.deleteData(recipe: recipe)
    }
    
    // get favorite recipes that will be used to display views
    public func getFavoryRecipes() -> [Recipe] {
        return coreDataStack.getFavoryRecipes()
    }
}
