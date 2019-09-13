//
//  RecipesListViewController.swift
//  Reciplease
//
//  Created by Margarita Blanc on 21/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class RecipesListViewController: UIViewController {

    // MARK: - Outlet
    
    @IBOutlet weak var recipesList: UITableView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Properties

    var viewModel: RecipesListViewModel!
    
    private var recipeDataSource = RecipesListDataSource()

    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        self.recipesList.dataSource = recipeDataSource
        self.recipesList.delegate = recipeDataSource
        
        bind(to: viewModel)
        bind(to: recipeDataSource)

        viewModel.viewDidLoad()
    }
    
    private func configureUI() {
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.7063648105, green: 0.4434646964, blue: 0.2221123874, alpha: 1)
        self.navigationItem.title = "Recipe list"
        self.activityIndicator.hidesWhenStopped = true
        self.hideKeyboardWhenTappedAround()
    }
    
    private func bind(to source: RecipesListDataSource) {
        source.didSelectRecipe = viewModel.didSelect
    }
    
    private func bind(to viewModel: RecipesListViewModel) {
        
        viewModel.incomingRecipes = { [weak self] recipes in
            DispatchQueue.main.async {
                self?.recipeDataSource.update(foundRecipes: recipes)
                self?.recipesList.reloadData()
            }
        }
        
        viewModel.isLoading = { [weak self] state in
                switch state {
                case true:
                    self?.recipesList.isHidden = true
                    self?.activityIndicator.startAnimating()
                case false:
                    self?.recipesList.isHidden = false
                    self?.activityIndicator.stopAnimating()
            }
        }
    }
}
