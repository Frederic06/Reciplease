
//
//  File.swift
//  Reciplease
//
//  Created by Margarita Blanc on 21/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

protocol ResearchViewModelDelegate: class {
    func didReceiveRecipes(recipes: [RecipeItem])
    func noRecipes(message: Message)
}

final class SearchViewModel {
    
    // MARK: - Properties
    private let repository: SearchRepositoryType

    private weak var delegate: ResearchViewModelDelegate?
    
    private var item: RecipeItem?
    
    private var ingredientList: [String] = [] {
        didSet {
            ingredients?(ingredientList)
        }
    }
    
    // MARK: - Init
    init(repository: SearchRepositoryType, delegate: ResearchViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: - Output

    var titleText: ((String) -> Void)?
    
    var viewTitleText: ((String) -> Void)?
    
    var placeHolderTextField: ((String) -> Void)?
    
    var addButtonText: ((String) -> Void)?
    
    var yourIngredientsText: ((String) -> Void)?
    
    var clearButtonText: ((String) -> Void)?
    
    var ingredients: (([String]) -> Void)?
    
    var ingredientTextField: ((String) -> Void)?
    
    var searchButtonHidden: ((Bool) -> Void)?
    
    var searchButtonText: ((String) -> Void)?

    var isLoading: ((Bool) -> Void)?

    // MARK: - Input
    
    func viewDidLoad() {
        titleText?("Recipleased")
        viewTitleText?("What's in your fridge")
        placeHolderTextField?("Lemon, Cheese, Sausages")
        addButtonText?("Add")
        yourIngredientsText?("Your ingredients :")
        clearButtonText?("Clear")
        searchButtonHidden?(true)
        searchButtonText?("Search for recipes")
    }

    func didPressAdd(ingredient: String) {
        ingredientList.append(ingredient)
        ingredientTextField?("")
        searchButtonHidden?(false)
    }
    
    func didPressClear() {
        ingredientList = []
        searchButtonHidden?(true)
    }
    
     // Comment vérifier si les ingrédients sont corrects avant de lancer l'appel?
    func didPressSearchForRecipes() {
        
        let ingredientListString = ingredientList.joined(separator:" ")
        isLoading?(true)
        
        repository.getRecipes(ingredients: ingredientListString,
                success: {[weak self] recipes in
                self?.isLoading?(false)
                self?.delegate?.didReceiveRecipes(recipes: recipes)
            },
                onError: { [weak self] errorMessage in
                    let message = Message(title: "Title",
                                          content: "Content")
                    self?.delegate?.noRecipes(message: message)
                    
                self?.isLoading?(false)
                // Here we delegate an alert to the user
        })
    }
}
