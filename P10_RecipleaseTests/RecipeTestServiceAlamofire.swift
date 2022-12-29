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
        
        URLTest.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data = FakeResponseData.recipeCorrectData
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTest.self]
        let session = Alamofire.Session(configuration: configuration)
        
        recipeService = RecipeRequest(session: session)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfError() {
        
        URLTest.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let error: Error? = FakeResponseData.conversionError
            let data: Data? = nil
            return (response, data, error)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTest.self]
        let session = Alamofire.Session(configuration: configuration)
        
        recipeService = RecipeRequest(session: session)
        
        let expectation = XCTestExpectation(description: "wait for queue change.")
        
//        let response = recipeService.getRecipes(ingredients: ["lemon"], completion: { results in
//
//            guard case .failure(let error) = results else {
//                XCTFail("Fail")
//                return
//            }
//            XCTAssertNotNil(error)
//            expectation.fulfill()
//        })
//        wait(for: [expectation], timeout: 2)
    }
}
