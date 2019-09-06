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
    
    private func showRecipes(recipes: [RecipeItem]) {
        let viewController = screens.createRecipesListViewController(delegate: self, with: .search(recipes: recipes))
        presenter.pushViewController(viewController, animated: true)
    }
    
    private func showRecipesDetail(recipe: RecipeItem) {
        let viewController = screens.createRecipesDetailViewController(with: recipe)
        presenter.pushViewController(viewController, animated: true)
    }
    
    //    private func showAlert(for type: AlertType) {
    //        let alert = screens.createAlert(for: type)
    //        presenter.show(alert!, sender: nil)
    //    }
}

extension SearchCoordinator: ResearchViewModelDelegate {
    func noRecipes(message: Message) {
        //        showAlert(for: .noRecipes(message: message))
        print("NO RECIPE")
    }
    
    func didReceiveRecipes(recipes: [RecipeItem]) {
        showRecipes(recipes: recipes)
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
}

extension SearchCoordinator: RecipeDetaileViewModelType {
    
    func didPressFavorite(recipe: RecipeItem) {
        let recipeObject = RecipeObject(context: AppDelegate.viewContext)
        recipeObject.recipeImage = recipe.imageURLString
        recipeObject.recipeName = recipe.name
        
        try? AppDelegate.viewContext.save()
    }
    
    func didUnselectFavorite(recipe: RecipeItem) {
    }
}



