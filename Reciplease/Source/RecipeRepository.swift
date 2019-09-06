//
//  FavoritesRecipesListRepository.swift
//  Reciplease
//
//  Created by Bertrand BLOC'H on 23/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation
import CoreData

enum Result<T> {
    case success(value: T)
    case error(error: Error)
}

enum RequestType {
    case network
    case persistence
}

protocol RecipeRepositoryType: class {
    func getRecipes(ingredients: String, success: @escaping (Result<[RecipeItem]>) -> Void, onError: @escaping (String) -> Void)
}

final class RecipeRepository: RecipeRepositoryType {
    
    private let network: NetworkRequestType
    
    //    private let coredataContext: CoredataContextType
    
    let route = Route()
    
    let requestType: RequestType
    
    init(requestType: RequestType, network: NetworkRequestType) {
        self.requestType = requestType
        self.network = network
    }
    
    func getRecipes(ingredients: String, success: @escaping (Result<[RecipeItem]>) -> Void, onError: @escaping (String) -> Void) {
        
        switch requestType {
            
        case .network:
            guard let url = route.getURL(ingredients: ingredients) else { return }
            network.request(type: Recipes.self, url: url) { (result) in
                switch result {
                case .success(value: let recipeItems):
                    let result: [RecipeItem] = recipeItems.hits.map { return RecipeItem(name: $0.recipe.label,
                                                                                        imageURLString: $0.recipe.image,
                                                                                        ingredient: $0.recipe.ingredientLines.map { $0}) }
                    
                    success(.success(value: result))
                    
                case .error(error: let error):
                    onError(error.localizedDescription)
                }
                
            }
            
        case .persistence:
            let request: NSFetchRequest<RecipeObject> = RecipeObject.fetchRequest()
            
            guard let recipes = try? AppDelegate.viewContext.fetch(request) else { return}
            let recipeItem : [RecipeItem] = recipes.map  { return RecipeItem(name: $0.recipeName!,
                                                                             imageURLString: $0.recipeImage!,
                                                                             ingredient: [""])
                
            }
            success(.success(value: recipeItem))
        }
    }
}




