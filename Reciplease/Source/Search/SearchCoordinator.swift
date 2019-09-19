//
//  ResearchCoordinator.swift
//  Reciplease
//
//  Created by Margarita Blanc on 20/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class SearchCoordinator {
    
    // MARK: - Properties
    
    private let presenter: UINavigationController
    private let screens: Screens
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }
    
    // MARK: - Coordinator
    
    func start() {
        showResearch()
    }
    
    private func showResearch() {
        let viewController = screens.createResearchViewController(delegate: self, alertDelegate: self)
        presenter.viewControllers = [viewController]
    }
    
    private func showRecipes(ingredients: String) {
        let viewController = screens.createRecipesListViewController(ingredients: ingredients, delegate: self, alertDelegate: self, with: .search)
        presenter.pushViewController(viewController, animated: true)
    }
    
    private func showRecipesDetail(recipe: RecipeItem) {
        let viewController = screens.createRecipesDetailViewController(with: recipe, alertDelegate: self)
        presenter.pushViewController(viewController, animated: true)
    }
    
    private func showAlert(for type: AlertType) {
        guard let alert = screens.createAlert(for: type) else {return}
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension SearchCoordinator: SearchViewModelDelegate {
    func noRecipe(for type: AlertType) {
        showAlert(for: type)
    }
    
    func didSelectIngredients(ingredients: String) {
        showRecipes(ingredients: ingredients)
    }
}

extension SearchCoordinator: RecipesListViewModelDelegate {
    func didChoseRecipe(recipe: RecipeItem) {
        showRecipesDetail(recipe: recipe)
    }
}

extension SearchCoordinator: AlertDelegate {
    func displayAlert(type: AlertType) {
        showAlert(for: type)
    }
}
