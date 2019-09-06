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

    // MARK: - Properties

    var viewModel: RecipesListViewModel!
    
    private var recipeDataSource = RecipesListDataSource()


    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.recipesList.dataSource = recipeDataSource
        self.recipesList.delegate = recipeDataSource
        
        bind(to: viewModel)
        bind(to: recipeDataSource)
        
        viewModel.viewDidLoad()

//        bind(to: viewModel)
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
    }
    
    // MARK: - Actions
    
}
