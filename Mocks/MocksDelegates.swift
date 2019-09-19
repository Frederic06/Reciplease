//
//  MocksDelegates.swift
//  RecipleaseTests
//
//  Created by Margarita Blanc on 10/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import Reciplease
import XCTest

class MockSearchCoordinator: SearchViewModelDelegate, RecipesListViewModelDelegate {
    func noRecipe(for type: AlertType) {
    }
    
    
    func didChoseRecipe(recipe: RecipeItem) {
    }
    
    func didSelectIngredients(ingredients: String) {
    }
}
