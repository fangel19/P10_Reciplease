//
//  RecipeTestServiceAlamofire.swift
//  P10_RecipleaseTests
//
//  Created by angelique fourny on 29/12/2022.
//

import XCTest
import Alamofire
@testable import P10_Reciplease
import SwiftUI

class RecipeTestServiceAlamofire: XCTestCase {
    
    var recipeService: RecipeRequest!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.af.ephemeral
        configuration.protocolClasses = [URLTest.self] + (configuration.protocolClasses ?? [])
        let session = Alamofire.Session(configuration: configuration)
        recipeService = RecipeRequest(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
        recipeService  = nil
    }
    private var ingredientController = IngredientController()
    
    
    func testGetRecipeResponseKOErrorFakeResponseDataDataNil() {
        
        URLTest.loadingHandler = { request in
            let response = FakeResponseData.responseKO
            let error: Error? = FakeResponseData.conversionError
            let data: Data? = nil
            return (response, data, error)
        }
        
        let expectation = XCTestExpectation(description: "Result has arrived")
        recipeService.getRecipes(ingredients: [Ingredient.init(name: "Lemon")]) { (result)  in
            
            guard case .failure(let error) = result else {
                XCTFail("Error Status")
                return
            }
            
            XCTAssertNotNil(error)
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 3)
    }
    
    func testGetRecipeResponseOKErroNilDataIncorrect() {
        
        URLTest.loadingHandler = { request in
            let response = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.incorrectData
            return (response, data, error)
        }
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        recipeService.getRecipes(ingredients: [Ingredient.init(name: "Lemon")]) { (result)  in
            
            guard case .success(let recipe) = result else {
                XCTFail("Error Status")
                return
            }
            guard let list = recipe.hits else { return }
            XCTAssertNotNil(list)
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetRecipeResponseKOErroNilDataIncorrect() {
        
        URLTest.loadingHandler = { request in
            let response = FakeResponseData.responseKO
            let error: Error? = nil
            let data: Data? = FakeResponseData.incorrectData
            return (response, data, error)
        }
        
        let alert = ingredientController
        let expectation = XCTestExpectation(description: "Wait for queue change")
        recipeService.getRecipes(ingredients: [Ingredient.init(name: "poule")]) { (result)  in
            
            guard case .failure = result else { return }
            XCTAssertTrue(alert.alertMessage(title: "Erreur", message: "Il n'y a pas d'ingredients qui correspond a une recette") == alert.alertMessage(title: "Erreur", message: "Il n'y a pas d'ingredients qui correspond a une recette"))
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 10)
    }
    
    func testshouldGetRecipe() {
        
        URLTest.loadingHandler = { request in
            let response = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.recipeCorrectData
            return (response, data, error)
        }
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        recipeService.getRecipes(ingredients: [Ingredient.init(name: "Lemon")]) { (result) in
            
            guard case .success(let recipeInfo) = result else {
                XCTFail("Error Status")
                return
            }
            XCTAssertEqual(recipeInfo.hits![0].recipe.label, "Lemon Confit")
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testAlertWhenEmptyArray() {
        
        let array = [Ingredient]()
        let expectation = XCTestExpectation(description: "Wait for queue change")
        let alert = ingredientController
        
        recipeService.getRecipes(ingredients: array) { (result) in
            
            guard case .failure(let error) = result else { return }
            
            XCTAssertTrue(alert.alertMessage(title: "Erreur", message: error.localizedDescription) == alert.alertMessage(title: "Erreur", message: error.localizedDescription))
            XCTAssertTrue(array.isEmpty)
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 3)
    }
}
