//
//  RecipesListViewModel.swift
//  Reciplease
//
//  Created by Margarita Blanc on 21/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

protocol RecipesListViewModelDelegate: class {
    func didChoseRecipe(recipe: RecipeItem)
}

class RecipesListViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: RecipesListViewModelDelegate?
    
    private weak var alertDelegate: AlertDelegate?
    
    private var repository: RecipeRepositoryType
    
    let route = Route()
    
    var recipes: [RecipeItem] = [] {
        didSet {
            if !recipes.isEmpty {
                incomingRecipes?(recipes)
            } else {
                alertDelegate?.displayAlert(type: .noRecipes)
            }
        }
    }
    
    private var ingredients: String

    // MARK: - Init

    init(ingredients: String, delegate: RecipesListViewModelDelegate, alertDelegate: AlertDelegate, repository: RecipeRepositoryType) {
        self.delegate = delegate
        self.repository = repository
        self.ingredients = ingredients
        self.alertDelegate = alertDelegate
    }
    // MARK: - Output

    var incomingRecipes: (([RecipeItem]) -> Void)?
    
    var isLoading: ((Bool) -> Void)?
    
    func viewWillAppear() {
        isLoading?(true)
        guard let url = route.getURL(ingredients: ingredients) else { return }
        repository.getRecipes(url: url, success: { [weak self] recipes in
                                switch recipes {
                                case .success(value: let
                                    recipeArray):
                                    self?.recipes = recipeArray
                                    self?.isLoading?(false)
                                case .error:
                                self?.alertDelegate?.displayAlert(type: .networkError)
                                }
            }, onError: { [weak self] error in
                self?.alertDelegate?.displayAlert(type: .networkError)
        })
    }
    
    func didSelect(recipe: RecipeItem) {
        delegate?.didChoseRecipe(recipe: recipe)
    }
}


