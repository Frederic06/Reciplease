//
//  FavoritesCoordinator.swift
//  Reciplease
//
//  Created by Margarita Blanc on 20/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class FavoritesCoordinator {
    
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
        showFavorites()
    }
    
    private func showFavorites() {
        let viewController = screens.createRecipesListViewController(ingredients: "", delegate: self, alertDelegate: self, with: .favorite)
        presenter.viewControllers = [viewController]
    }
    
    private func showFavoritesDetail(recipe: RecipeItem) {
        let viewController = screens.createRecipesDetailViewController(with: recipe, alertDelegate: self)
        presenter.pushViewController(viewController, animated: true)
    }
    
    private func showAlert(for type: AlertType) {
        guard let alert = screens.createAlert(for: type) else {return}
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension FavoritesCoordinator: RecipesListViewModelDelegate {
    func didChoseRecipe(recipe: RecipeItem) {
        showFavoritesDetail(recipe: recipe)
    }
}

extension FavoritesCoordinator: AlertDelegate {
    func displayAlert(type: AlertType) {
        showAlert(for: type)
    }
}
