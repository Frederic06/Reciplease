//
//  FavoritesRecipesListRepository.swift
//  Reciplease
//
//  Created by Bertrand BLOC'H on 23/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation
import CoreData


struct Recipe {
    
}

enum Result<T> {
    case succes(value: T)
    case error(error: Error)
}



final class FavoriteRepository: RecipesListRepositoryType {

    

    func getRecipes(callback: @escaping (Result<[RecipeItem]>) -> Void) {
        let request: NSFetchRequest<RecipeObject> = RecipeObject.fetchRequest()
        
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else { return}
//
//        let recipeItem : [RecipeItem] = recipes.map  { return RecipeItem(name: $0.recipeName!,
//                                                                        imageURLString: $0.recipeImage!,
//                                                                        ingredient: $0.recipe.ingredientLines.map { $0}) }
//        callback(recipeItem)
    }
}
