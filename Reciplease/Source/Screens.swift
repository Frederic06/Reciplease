//
//  Screens.swift
//  Reciplease
//
//  Created by Margarita Blanc on 20/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

// Class Screens instantiates ViewControllers, as well as ViewController parameters: le ViewModel
final class Screens {
    
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))
}

// MARK: - Search

extension Screens {
    func createResearchViewController(delegate: ResearchViewModelDelegate?) -> UIViewController {
        // For creating a view, we call instance of storyBoard, with identifier we cast with the type we want
        let viewController = storyboard.instantiateViewController(withIdentifier: "ResearchVC") as! SearchViewController
        let repository = SearchRepository()
        let viewModel = SearchViewModel(repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Recipe List

enum RecipeListType {
    case search(recipes: [RecipeItem])
    case favorite
}

extension Screens {
    func createRecipesListViewController(delegate: RecipesListViewModelDelegate, with listType: RecipeListType) -> UIViewController {
        // Same VC for RecipesList or FavoriteList (so only one UIViewController in Storyboard -> One ID), differs only where the datas come from : API in the case of search, data persistence in case of favorite
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecipesListViewController") as! RecipesListViewController
        switch listType {
        case .favorite:
            let repository = FavoriteRepository()
            let viewModel = RecipesListViewModel(recipes: nil, delegate: delegate, repository: repository)
            viewController.viewModel = viewModel
            break // Instanciate the correct viewModel
        case .search(recipes: let recipes):
            let viewModel = RecipesListViewModel(recipes: recipes, delegate: delegate, repository: nil)
            viewController.viewModel = viewModel
        }
        return viewController
    }
}

// MARK: - Recipe Details


extension Screens {
    func createRecipesDetailViewController(with recipe: RecipeItem) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecipesDetailViewController") as! RecipeDetailViewController
        
        let viewModel = RecipeDetailViewModel(recipe: recipe)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Alert


enum AlertType {
    case noRecipes(message: Message)
}
extension Screens {
    func createAlert(for type: AlertType) -> UIAlertController? {
        return nil
    }
}
