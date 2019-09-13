//
//  RecipesListViewModelTests.swift
//  RecipleaseTests
//
//  Created by Margarita Blanc on 10/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipesListViewModelTests: XCTestCase {
    
    let ingredients = "Ham, Cheese"
    
    func testGivenARecipesListViewModelGivenARepositoryWithTestDataWhenInitThenPropertiesAreCorrecltyReturned() {
        
        let delegate: RecipesListViewModelDelegate = MockSearchCoordinator()
        
        let repository = MockRecipeRepository()
        
        let recipe1: RecipeItem = RecipeItem(name: "Choucroute garnie", imageURLString: "https://www.ceinfo.fr/image/choucroute/choucroute.jpg", url: "https://www.ceinfo.fr/image/choucroute", ingredient: ["vin blanc", "saucisse", "choux"])
        
        let recipe2: RecipeItem = RecipeItem(name: "Spaghetti carbonara", imageURLString: "https://gourmandiz.dhnet.be/app/uploads/2018/03/carbonara-e1521461363147.jpg", url: "https://gourmandiz.dhnet.be/app/", ingredient: ["spaghetti", "sel", "lardons"])
        
                let recipe3: RecipeItem = RecipeItem(name: "boeuf bourguignon", imageURLString: "https://img-3.journaldesfemmes.fr/-7vMWJsFliDbMuV-mJj7oBhCUsw=/800x600/smart/image-icu/10002051_1603680841.jpg", url: "https://img-3.journaldesfemmes.fr/-7vMWJsFliDbMuV-mJj7oBhCUsw=/800x600/", ingredient: ["plat de cote", "vin rouge", "carottes"])
        
        let recipesTest: [RecipeItem] = [recipe1, recipe2, recipe3]
        repository.recipeItem = recipesTest
        
        let viewModel = RecipesListViewModel(ingredients: ingredients, delegate: delegate, repository: repository)
        
        let expectation1 = self.expectation(description: "Returned incomingRecipes")
//        let expectation2 = self.expectation(description: "Returned isLoading")
        
        viewModel.incomingRecipes = { recipes in
            XCTAssertEqual(recipes, recipesTest)

            expectation1.fulfill()

        }

        
        
        
    }
}
