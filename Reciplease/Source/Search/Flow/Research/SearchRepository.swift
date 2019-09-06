//
//  SearchRepository.swift
//  Reciplease
//
//  Created by Margarita Blanc on 21/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

protocol SearchRepositoryType {
    func getRecipes(ingredients: String, success: @escaping ([RecipeItem]) -> Void, onError: @escaping (String) -> Void)
}

class SearchRepository: SearchRepositoryType {
    
    let route = Route()
    
    private let client = NetworkRequest()
    
    func getRecipes(ingredients: String, success: @escaping ([RecipeItem]) -> Void, onError: @escaping (String) -> Void) {
        guard let url = route.getURL(ingredients: ingredients) else { return }
        client.request(type: Recipes.self, url: url) { (result) in
            switch result {
            case .succes(value: let recipeItems):
                let result: [RecipeItem] = recipeItems.hits.map { return RecipeItem(name: $0.recipe.label,
                                                                                 imageURLString: $0.recipe.image,
                                                                                 ingredient: $0.recipe.ingredientLines.map { $0}) }
                success(result)
            case .error(error: let error):
                onError(error.localizedDescription)
            }
            
        }
    }
}
