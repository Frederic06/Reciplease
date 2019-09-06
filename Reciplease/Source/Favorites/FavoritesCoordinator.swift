//
//  FavoritesCoordinator.swift
//  Reciplease
//
//  Created by Margarita Blanc on 20/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

//class Context {
//    let theme: Theme
//    let translator: Translator
//}

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
        print("showFavorites")
        let viewController = screens.createRecipesListViewController(delegate: self, with: .favorite)
        presenter.viewControllers = [viewController]
    }
    
    private func showFavoritesDetail(recipe: RecipeItem) {
        let viewController = screens.createRecipesDetailViewController(with: recipe)
        presenter.pushViewController(viewController, animated: true)
    }
}

extension FavoritesCoordinator: RecipesListViewModelDelegate {
    func didChoseRecipe(recipe: RecipeItem) {
        showFavoritesDetail(recipe: recipe)
    }
    
    func noRecipes(message: Message) {
        print(message)
    }
    
    
}



