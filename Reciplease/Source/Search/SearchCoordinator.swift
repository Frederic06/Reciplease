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
        let viewController = screens.createResearchViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    private func showRecipes(ingredients: String) {
        let viewController = screens.createRecipesListViewController(ingredients: ingredients, delegate: self, with: .search)
        presenter.pushViewController(viewController, animated: true)
    }
    
    private func showRecipesDetail(recipe: RecipeItem) {
        let viewController = screens.createRecipesDetailViewController(with: recipe)
        presenter.pushViewController(viewController, animated: true)
    }
    
        private func showAlert(for type: AlertType) {
            let alert = screens.createAlert(for: type)
            presenter.show(alert!, sender: nil)
        }
}

extension SearchCoordinator: ResearchViewModelDelegate {
    func didSelectIngredients(ingredients: String) {
        showRecipes(ingredients: ingredients)
    }
    
    func noRecipes(message: Message) {
        //        showAlert(for: .noRecipes(message: message))
        print("NO RECIPE")
    }
}

struct Message {
    let title: String
    let content: String
}

extension SearchCoordinator: RecipesListViewModelDelegate {
    func didChoseRecipe(recipe: RecipeItem) {
        
        showRecipesDetail(recipe: recipe)
    }
    func alertNoRecipe(message: Message) {
        print(message)
    }
}

extension SearchCoordinator: RecipeDetaileViewModelType {

}



