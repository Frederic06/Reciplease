//
//  RecipeDetailViewModel.swift
//  Reciplease
//
//  Created by Margarita Blanc on 21/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

protocol RecipeDetaileViewModelType: class {
    func didPressFavorite(recipe: RecipeItem)
    func didUnselectFavorite(recipe: RecipeItem)
}

final class RecipeDetailViewModel {
    
    private var recipe: RecipeItem
    
    private weak var delegate: RecipeDetaileViewModelType?
    
    

    // MARK: - Output
    var incomingRecipe: ((RecipeItem) -> Void)?
    
    var recipeImage: ((UIImage) -> Void)?

    // MARK: - Init
    init(recipe: RecipeItem) {
        self.recipe = recipe
    }
    
    // MARK: - Methods
    
    func viewDidLoad() {
        guard let image = recipe.imageURLString.transformToImage() else { return }
        recipeImage?(image)
        
        incomingRecipe?(recipe)
    }

// MARK: - Input
    
    func clickedOnFavoriteStar() {
        delegate?.didPressFavorite(recipe: recipe)
        
        let recipeObject = RecipeObject(context: AppDelegate.viewContext)
        recipeObject.recipeImage = recipe.imageURLString
        recipeObject.recipeName = recipe.name
        
        try? AppDelegate.viewContext.save()
    }
    
    func unClickedOnFavoriteStar() {
        delegate?.didUnselectFavorite(recipe: recipe)
    }

}


