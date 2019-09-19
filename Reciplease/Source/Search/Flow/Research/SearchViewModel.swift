
//
//  File.swift
//  Reciplease
//
//  Created by Margarita Blanc on 21/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

protocol SearchViewModelDelegate: class {
    func didSelectIngredients(ingredients: String)
    func noRecipe(for type: AlertType)
}

final class SearchViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: SearchViewModelDelegate?
    
    private weak var alertDelegate: AlertDelegate?
    
    private var item: RecipeItem?
    
    private var ingredientList: [String] = [] {
        didSet {
            guard ingredientList != [] else {self.alertDelegate?.displayAlert(type: .noIngredient); return}
            ingredients?(ingredientList)
        }
    }
    
    // MARK: - Init
    
    init(delegate: SearchViewModelDelegate?, alertDelegate: AlertDelegate?) {
        self.delegate = delegate
        self.alertDelegate = alertDelegate
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

    // MARK: - Input
    
    func viewDidLoad() {
        titleText?("Recipleased")
        viewTitleText?("What's in your fridge?")
        placeHolderTextField?("Lemon, Cheese, Sausages ...")
        addButtonText?("Add")
        yourIngredientsText?("Your ingredients :")
        clearButtonText?("Clear!")
        searchButtonHidden?(true)
        searchButtonText?("Search for recipes!!")
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
    
    func didPressSearchForRecipes() {
        let ingredientListString = ingredientList.joined(separator:" ")
        
        self.delegate?.didSelectIngredients(ingredients: ingredientListString)
    }
}
