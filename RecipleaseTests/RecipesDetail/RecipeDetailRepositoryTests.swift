//
//  RecipeDetailRepositoryTests.swift
//  RecipleaseTests
//
//  Created by Margarita Blanc on 10/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import Reciplease
import XCTest

class RecipeDetailRepositoryTests: XCTestCase {
    func testGivenARecipeDetailRepositoryCheckIfRecipeIsCorrectlyAddedToFavorite() {
        
        let recipe = RecipeItem(name: "Choucroute", imageURLString: "imageString", url: "url", ingredient: ["Choux", "Saucisse", "Vin Blanc"])
        
        let repository = RecipeDetailRepository()
        
        repository.addToFavorite(recipe: recipe)
        
        let expectation1 = self.expectation(description: "Correctly added to Favorites")
        
        repository.checkIfFavorite(recipeName: recipe.name) { (status) in
            XCTAssertEqual(status, true)
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenARecipeDetailRepositoryCheckIfRecipeIsCorrectlyRemovedFromFavorite() {
        
        let repository = RecipeDetailRepository()
        
        let expectation1 = self.expectation(description: "Correctly added to Favorites")
        
        repository.removeFavorite(recipeName: "Choucroute")
        
        repository.checkIfFavorite(recipeName: "Choucroute") { (status) in
            XCTAssertEqual(status, false)
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

