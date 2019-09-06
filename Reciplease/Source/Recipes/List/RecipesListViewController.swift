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
        self.hideKeyboardWhenTappedAround()
        
        self.activityIndicator.color = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        self.activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        self.activityIndicator.hidesWhenStopped = true
        
        
        self.recipesList.dataSource = recipeDataSource
        self.recipesList.delegate = recipeDataSource
        
        bind(to: viewModel)
        bind(to: recipeDataSource)
    }
    
    private func bind(to source: RecipesListDataSource) {
        source.didSelectRecipe = viewModel.didSelect
    }

    private func bind(to viewModel: RecipesListViewModel) {
        
        viewModel.incomingRecipes = { [weak self] recipes in
            print("Incoming Recipes")
            DispatchQueue.main.async {
            self?.recipeDataSource.update(foundRecipes: recipes)
            self?.recipesList.reloadData()
            }
        }
        
        viewModel.isLoading = { [weak self] state in
            print("Incoming State")
            switch state {
            case true:
                self?.activityIndicator.startAnimating()
            case false:
                self?.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.output = { [weak self] text in
            print(text)
        }
    }
}
