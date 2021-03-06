//
//  RecipeDetailViewModel.swift
//  Reciplease
//
//  Created by Margarita Blanc on 21/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class RecipeDetailViewModel {
    
    private var repository: RecipeDetailRepositoryType
    
    private var recipe: RecipeItem
    
    private weak var alertDelegate: AlertDelegate?
    
    // MARK: - Output
    var incomingRecipe: ((RecipeItem) -> Void)?
    
    var recipeImage: ((String) -> Void)?
    
    var isFavorite: ((Bool) -> Void)?
    
    var recipeButton: ((String) -> Void)?

    // MARK: - Init
    init(recipe: RecipeItem, repository: RecipeDetailRepositoryType, alertDelegate: AlertDelegate) {
        self.recipe = recipe
        self.repository = repository
        self.alertDelegate = alertDelegate
    }
    
    // MARK: - Methods
    
    func viewDidLoad() {
        incomingRecipe?(recipe)
        recipeButton?("Get directions!!")
        recipeImage?(recipe.imageURLString)
        
        repository.checkIfFavorite(recipeName: recipe.name) { (favoriteState) in
            self.isFavorite?(favoriteState)
        }
    }

    // MARK: - Input
    
    func clickedOnFavoriteStar() {
        repository.checkIfFavorite(recipeName: recipe.name) { (favoriteState) in
            switch favoriteState {
            case true:
                repository.removeFavorite(recipeName: recipe.name)
                isFavorite?(false)
            case false:
                repository.addToFavorite(recipe: recipe)
                isFavorite?(true)
            }
        }
    }
    
    func clickedOnDirectionButton() {
        if let url = URL(string: recipe.url) {
            UIApplication.shared.open(url)
        }
    }
}


