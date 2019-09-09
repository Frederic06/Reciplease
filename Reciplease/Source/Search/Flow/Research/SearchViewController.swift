//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Margarita Blanc on 20/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var viewTitle: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var ingredientsListTitle: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var ingredientsList: UITableView!
    
    @IBOutlet weak var searchRecipesButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Properties
    var viewModel: SearchViewModel!
    
    private lazy var ingredientListDataSource = IngredientListTableDataSource()

    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        configureUI()
        self.ingredientsList.dataSource = ingredientListDataSource

//          bind(to: viewModel)
        bind(to: viewModel)

        //          bind(to: datasource)
        viewModel.viewDidLoad()
    }
    
    private func configureUI() {
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.7063648105, green: 0.4434646964, blue: 0.2221123874, alpha: 1)
        self.navigationItem.title = "Recipe search"
    }
    
    private func bind(to viewModel: SearchViewModel) {
        viewModel.viewTitleText = { [weak self] text in
            self?.viewTitle.text = text
        }
        
        viewModel.addButtonText = { [weak self] text in
            self?.addButton.setTitle(text, for: .normal)
        }
        
        viewModel.placeHolderTextField = {
            [weak self] text in
            self?.textField.placeholder = text
        }
        
        viewModel.ingredientTextField = { [weak self] text in
            self?.textField.text = text
        }
        
        viewModel.yourIngredientsText = { [weak self] text in
            self?.ingredientsListTitle.text = text
        }
        
        viewModel.clearButtonText = { [weak self] text in
            self?.clearButton.setTitle(text, for: .normal)
        }
        
        viewModel.searchButtonHidden = { [weak self] state in
            self?.searchRecipesButton.isHidden = state
        }
        
        viewModel.searchButtonText = { [weak self] text in
            self?.searchRecipesButton.setTitle(text, for: .normal)
        }
        
        viewModel.ingredients = { [weak self] item in
            DispatchQueue.main.async {
                self?.ingredientListDataSource.update(with: item)
                self?.ingredientsList.reloadData()
            }
        }

        viewModel.isLoading = { [weak self] state in
            switch state {
            case true:
                self?.activityIndicator.startAnimating()
            case false:
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func bind(to source: IngredientListTableDataSource) {
    }
    
    // MARK: - Actions
    @IBAction func addIngretientButton(_ sender: UIButton) {
        guard let ingredient = self.textField.text?.firstUppercased else { return }
        viewModel.didPressAdd(ingredient: ingredient)
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        viewModel.didPressClear()
    }
    
    @IBAction func searchRecipesButton(_ sender: UIButton) {
        viewModel.didPressSearchForRecipes()
    }
    
}
