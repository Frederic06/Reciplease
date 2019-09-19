//
//  RecipesListViewModelTests.swift
//  RecipleaseTests
//
//  Created by Margarita Blanc on 10/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import XCTest
@testable import Reciplease

final class RecipeListeViewModelTests: XCTestCase {
    func testGivenaRecipeListVMPropertiesCorrectlyReturned() {
        let delegate = MockSearchCoordinator()
        let alertDelegate = MockAlertDelegate()
        let repository = MockRecipeRepository()
        let viewModel = RecipesListViewModel(ingredients: "",
                                             delegate: delegate,
                                             alertDelegate: alertDelegate,
                                             repository: repository)
        
        let expectedValue = [RecipeItem(name: "Choucroute",
                                        imageURLString: "https://url",
                                        url: "url",
                                        ingredient: ["vin blanc",
                                                     "choux",
                                                     "saucisse"])]
        repository.recipeItem = expectedValue
        
        let expectation1 = self.expectation(description: "Returned incomingRecipes")
        
        viewModel.incomingRecipes = { recipe in
            print(recipe)
            XCTAssertEqual(recipe, expectedValue)
            expectation1.fulfill()
        }
        
        viewModel.viewWillAppear()
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
    }
}
