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

protocol RecipesListRepositoryType: class {
    func getRecipes(callback: @escaping (Result<[RecipeItem]>) -> Void)
}

//final class RecipesListRepository: RecipesListRepositoryType {
//
//    private let network: NetworkRequestType
//
//    private let coredataContext: CoredataContextType
//    
//    enum RequestType {
//        case network
//        case persistence
//    }
//
//    let requestType: RequestType
//
//    init(requestType: RequestType) {
//        self.requestType = requestType
//        
//    }
//
//    func getRecipes(callback: @escaping (Result<[RecipeItem]>) -> Void) {
//        switch requestType {
//        case .network:
//            nnetwork.
//        case .persistence:
//            
//        }
//    }
//}

class RecipesListViewModel {
    
    // MARK: - Properties
    private weak var delegate: RecipesListViewModelDelegate?
    
    private weak var repository: RecipesListRepositoryType?
    
    private var recipes: [RecipeItem] = []

    // MARK: - Init

    init(recipes: [RecipeItem]?, delegate: RecipesListViewModelDelegate, repository: RecipesListRepositoryType?) {
        self.delegate = delegate
        
        if let recipes = recipes {
            self.recipes = recipes
        } else {
            guard let repository = repository else { return }
            self.repository = repository
            repository.getRecipes { (result) in
//                switch result {
//                case .succes(value: recipes):
//                case .error(error: <#T##Error#>)
//                }
                //                self.recipes = recipes
                
            }
        }
    }
    
    func viewDidLoad() {
        incomingRecipes?(self.recipes)
    }

    // MARK: - Output
//
    var incomingRecipes: (([RecipeItem]) -> Void)?

    // MARK: - Input
    
    func didSelect(recipe: RecipeItem) {
        delegate?.didChoseRecipe(recipe: recipe)
    }

}


