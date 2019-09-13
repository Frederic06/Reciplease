//
//  RecipeDetailViewModelTests.swift
//  RecipleaseTests
//
//  Created by Margarita Blanc on 10/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//
//      recipeButton?("Get directions!!")

import Foundation

import XCTest
@testable import Reciplease

class RecipeDetailViewModelTests: XCTestCase {
    
    func testGivenARecipeDetailViewModelWhenViewDidLoadThenInitialrecipeButtonIsCorrecltyReturned() {
        
        let recipe = RecipeItem(name: "Spaghetti Bolognese", imageURLString: "https://www.papillesetpupilles.fr/wp-content/uploads/2013/08/Spaghetti-Bolognese-1150x0.jpg", url: "https://www.papillesetpupilles.fr/2013/08/spaghetti-bolognese.html", ingredient: ["spaghetti", "tomato sauce", "beef", "sal", "pepper"])
        
        let repository = MockRecipeDetailRepository()
//
        let viewModel = RecipeDetailViewModel(recipe: recipe, repository: repository)
//
        let expectation1 = self.expectation(description: "Returned recipeButton")
        
        viewModel.recipeButton = { text in
            XCTAssertEqual(text, "Get directions!!")
            expectation1.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
        
        
    }
    
    func testGivenARecipeDetailViewModelWhenViewDidLoadThenPropertiesAreCorrecltyReturned() {
        
        let recipe = RecipeItem(name: "Spaghetti Bolognese", imageURLString: "https://www.papillesetpupilles.fr/wp-content/uploads/2013/08/Spaghetti-Bolognese-1150x0.jpg", url: "https://www.papillesetpupilles.fr/2013/08/spaghetti-bolognese.html", ingredient: ["spaghetti", "tomato sauce", "beef", "sal", "pepper"])
        
        let repository = MockRecipeDetailRepository()
        //
        let viewModel = RecipeDetailViewModel(recipe: recipe, repository: repository)
        //
        let expectation1 = self.expectation(description: "Returned incomingRecipe")
        
        let expectation2 = self.expectation(description: "Returned recipeImage")
//
//                let expectation3 = self.expectation(description: "Returned isFavorite")
        
        
        viewModel.incomingRecipe = { recipe in
            XCTAssertEqual(recipe, recipe)
            expectation1.fulfill()
        }
        
        viewModel.recipeImage = { imageURL in
            XCTAssertEqual(imageURL, recipe.imageURLString)
            expectation2.fulfill()
        }
//
//        var isFavorite: ((Bool) -> Void)?
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    

}
