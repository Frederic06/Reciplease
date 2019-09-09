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
    
    private var favoriteArray = [""]
    
    private var selected: Bool = false
    
    // MARK: - Output
    var incomingRecipe: ((RecipeItem) -> Void)?
    
    var recipeImage: ((UIImage) -> Void)?
    
    var isFavorite: ((Bool) -> Void)?

    // MARK: - Init
    init(recipe: RecipeItem) {
        self.recipe = recipe
    }
    
    // MARK: - Methods
    
    func viewDidLoad() {
        incomingRecipe?(recipe)
        guard let image = recipe.imageURLString.transformURLToImage() else { return }
        recipeImage?(image)
    }

// MARK: - Input
    
    func clickedOnFavoriteStar() {
        delegate?.didPressFavorite(recipe: recipe)
        let recipeObject = RecipeObject(context: AppDelegate.viewContext)
        recipeObject.recipeImage = recipe.imageURLString
        recipeObject.recipeName = recipe.name
        recipeObject.recipeIngredients = recipe.ingredient as NSObject
        try? AppDelegate.viewContext.save()
    }
    
    func unClickedOnFavoriteStar() {
        delegate?.didUnselectFavorite(recipe: recipe)
    }

}


