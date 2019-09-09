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
    func alertNoRecipe(message: Message)
}

class RecipesListViewModel {
    
    // MARK: - Properties
    private weak var delegate: RecipesListViewModelDelegate?
    
    private var repository: RecipeRepositoryType
    
    private var recipes: [RecipeItem] = [] {
        didSet {
            incomingRecipes?(recipes)
            isLoading?(false)
        }
    }

    // MARK: - Init

    init(ingredients: String, delegate: RecipesListViewModelDelegate, repository: RecipeRepositoryType) {
        isLoading?(true)
        self.delegate = delegate
        self.repository = repository
        repository.getRecipes(ingredients: ingredients,
                                success: { [weak self] recipes in
                                    switch recipes {
                                    case .success(value: let recipeArray):
                                        self?.recipes = recipeArray
                                    case .error:
                                        print("error")
                                    }

            }, onError: { [weak self] error in
                print(error)
        })
    }
    // MARK: - Output

    var incomingRecipes: (([RecipeItem]) -> Void)?
    
    var isLoading: ((Bool) -> Void)?
    
    var outlet: ((String) -> Void)?
    
    // MARK: - Methods
    
    func viewDidLoad() {
        incomingRecipes?(recipes)
    }
    
    func didSelect(recipe: RecipeItem) {
        delegate?.didChoseRecipe(recipe: recipe)
    }
}


