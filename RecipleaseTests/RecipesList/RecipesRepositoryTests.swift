//
//  RecipesRepositoryTests.swift
//  RecipleaseTests
//
//  Created by Margarita Blanc on 10/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import Reciplease
import XCTest


class RecipeRepositoryTests: XCTestCase {
    func testGivenARecipeRepositoryWhenCallingIsCorrectly() {
        
        let network = MockNetworkRequest()
        
        let recipeRepository = RecipeRepository(requestType: .network, network: network)
        
        guard let path = Bundle.main.path(forResource: "FakeRecipes", ofType: "json") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        let expectation1 = self.expectation(description: "Returned not nil")
        
        let expectation2 = self.expectation(description: "Returned correctly recept")
        
        recipeRepository.getRecipes(url: url, success: { (result) in
            switch result {
            case .success(value: let recipeItems):
                XCTAssertNotNil(recipeItems)
                expectation1.fulfill()
                
                XCTAssertEqual(recipeItems[0].name, "Chicken Vesuvio")
                expectation2.fulfill()
                
                XCTAssertEqual(recipeItems[1].imageURLString, "https://www.edamam.com/web-img/e12/e12b8c5581226d7639168f41d126f2ff.jpg")
                
                print(recipeItems[2].ingredient, ["4 cups chicken bones and wings", "2 tablespoons unsalted butter, softened", "2 tablespoons all-purpose flour", "4 cups homemade bruce and eric bromberg\'s chicken stock, or store-bought low-sodium chicken stock", "1 tablespoon fresh thyme leaves", "Coarse salt and freshly ground black pepper"])
                
            case .error(error: let error):
                print(error)
            }
        }) { (error) in
            print(error)
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
