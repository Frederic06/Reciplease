//
//  Screens.swift
//  Reciplease
//
//  Created by Margarita Blanc on 20/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class Screens {
    
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))
}

// MARK: - Search

extension Screens {
    func createResearchViewController(delegate: SearchViewModelDelegate?, alertDelegate: AlertDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "ResearchVC") as! SearchViewController
        let viewModel = SearchViewModel(delegate: delegate, alertDelegate: alertDelegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Recipe List

enum RecipeListType {
    case search
    case favorite
}

extension Screens {
    func createRecipesListViewController(ingredients: String, delegate: RecipesListViewModelDelegate, alertDelegate: AlertDelegate, with listType: RecipeListType) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecipesListViewController") as! RecipesListViewController
        switch listType {
        case .favorite:
            let network = NetworkRequest()
            let repository = RecipeRepository(requestType: .persistence, network: network)
            let viewModel = RecipesListViewModel(ingredients: ingredients, delegate: delegate, alertDelegate: alertDelegate, repository: repository)
            viewController.viewModel = viewModel
        case .search:
            let network = NetworkRequest()
            let repository = RecipeRepository(requestType: .network, network: network)
            let viewModel = RecipesListViewModel(ingredients: ingredients, delegate: delegate, alertDelegate: alertDelegate, repository: repository)
            viewController.viewModel = viewModel
        }
        return viewController
    }
}

// MARK: - Recipe Details

extension Screens {
    func createRecipesDetailViewController(with recipe: RecipeItem, alertDelegate: AlertDelegate) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecipesDetailViewController") as! RecipeDetailViewController
        let repository = RecipeDetailRepository()
        let viewModel = RecipeDetailViewModel(recipe: recipe, repository: repository, alertDelegate: alertDelegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Alert

extension Screens {
    func createAlert(for type: AlertType) -> UIAlertController? {
            let alert = Alert(type: type)
            let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .actionSheet)
            let yesButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(yesButton)
            return alertController
    }
}
