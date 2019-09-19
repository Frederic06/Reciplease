//
//  MockRecipeRepository.swift
//  RecipleaseTests
//
//  Created by Margarita Blanc on 10/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import Reciplease
import XCTest


class MockRecipeRepository: RecipeRepositoryType {
    
    var recipeItem: [RecipeItem]?
    
    func getRecipes(url: URL, success: @escaping (Result<[RecipeItem]>) -> Void, onError: @escaping (String) -> Void) {
        if let recipeItem = recipeItem {
            success(.success(value: recipeItem))
        } else {
            onError("Error Returned")
        }
    }
}
