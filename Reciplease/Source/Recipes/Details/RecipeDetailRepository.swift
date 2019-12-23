//
//  RecipeDetailRepository.swift
//  Reciplease
//
//  Created by Margarita Blanc on 10/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation
import CoreData

protocol RecipeDetailRepositoryType {
    func addToFavorite(recipe: RecipeItem)
    func checkIfFavorite(recipeName: String, completion: (Bool) -> Void)
    func removeFavorite(recipeName: String)
}

final class RecipeDetailRepository: RecipeDetailRepositoryType {
    
    func checkIfFavorite(recipeName: String, completion: (Bool) -> Void) {
        let request: NSFetchRequest<RecipeObject> = RecipeObject.fetchRequest()
        request.predicate = NSPredicate(format: "recipeName == %@", recipeName)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \RecipeObject.recipeName, ascending: true)]
        
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else { print("error") ; return }
        
        if recipes == [] {completion(false); return }
        
        completion(true)
    }
    
    func addToFavorite(recipe: RecipeItem) {
        let recipeObject = RecipeObject(context: AppDelegate.viewContext)
        recipeObject.recipeImage = recipe.imageURLString
        recipeObject.recipeName = recipe.name
        recipeObject.recipeIngredients = recipe.ingredient.joined(separator: "@")
        recipeObject.recipeURL = recipe.url
        try? AppDelegate.viewContext.save()
    }
    
    func removeFavorite(recipeName: String) {
        
            let request: NSFetchRequest<RecipeObject> = RecipeObject.fetchRequest()
            request.predicate = NSPredicate(format: "recipeName == %@", recipeName)
            
        do {
            let object = try AppDelegate.viewContext.fetch(request)
            if !object.isEmpty {
                AppDelegate.viewContext.delete(object[0])
                try? AppDelegate.viewContext.save()
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
