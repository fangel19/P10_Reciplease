//
//  RecipeTestServiceAlamofire.swift
//  P10_RecipleaseTests
//
//  Created by angelique fourny on 29/12/2022.
//

import XCTest
import Alamofire
@testable import P10_Reciplease

class RecipeTestServiceAlamofire: XCTestCase {
    
    var recipeService: RecipeRequest!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.af.ephemeral
        configuration.protocolClasses = [URLTest.self] + (configuration.protocolClasses ?? [])
        let session = Alamofire.Session(configuration: configuration)
        recipeService = RecipeRequest(session: session)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfError() {
        
        URLTest.loadingHandler = { request in
            let response = FakeResponseData.responseKO
            let error: Error? = FakeResponseData.conversionError
            let data: Data? = nil
            return (response, data, error)
        }
        
        let expectation = XCTestExpectation(description: "Result has arrived")
        
        recipeService.getRecipes(ingredients: [Ingredient.init(name: "Lemon")], completion: { (result, error) in
            
            XCTAssertTrue(result.isEmpty)
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2)
        
    }
    
    func testGetRecipeShouldPostFailedCallbackIncorrectData() {
        
        URLTest.loadingHandler = { request in
            let response = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.incorrectData
            return (response, data, error)
        }
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        recipeService.getRecipes(ingredients: [Ingredient.init(name: "Lemon")], completion: { (result, error) in
            
            XCTAssertTrue(result.isEmpty)
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2)
        
    }
    
    func testGetRecipeShouldPostFailedCallbackIfIncorrectResponse() {
        
        URLTest.loadingHandler = { request in
            let response = FakeResponseData.responseKO
            let error: Error? = nil
            let data: Data? = FakeResponseData.incorrectData
            return (response, data, error)
        }
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        recipeService.getRecipes(ingredients: [Ingredient.init(name: "Lemon")], completion: { (result, error) in

            XCTAssertTrue(result.isEmpty)
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2)
        
    }
    
    func testshouldGetRecipe() {
        
        URLTest.loadingHandler = { request in
            let response = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.recipeCorrectData
            return (response, data, error)
        }
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        recipeService.getRecipes(ingredients: [Ingredient.init(name: "Lemon")], completion: { (result, error) in
            XCTAssertTrue(result.contains(where: { $0.recipeName == "Lemon Confit" }))
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2)
        
    }
}
