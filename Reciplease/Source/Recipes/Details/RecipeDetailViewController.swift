//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Margarita Blanc on 21/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class RecipeDetailViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeDescription: UITableView!
    
    // MARK: - Properties
    var viewModel: RecipeDetailViewModel!
    
    private lazy var recipeDetailDataSource = RecipeDetailDataSource()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        configureUI()
        unselectedStar()
        self.recipeDescription.dataSource = recipeDetailDataSource
        
        bind(to: viewModel)
        
        viewModel.viewDidLoad()
    }

    @objc private func didPressFavorite() {
        viewModel.clickedOnFavoriteStar()
    }
    
    private func configureUI() {
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.7063648105, green: 0.4434646964, blue: 0.2221123874, alpha: 1)
        let button = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(didPressFavorite))
         self.navigationItem.setRightBarButton(button, animated: false)
        self.navigationItem.rightBarButtonItem = button
        self.navigationItem.title = "Recipe detail"
    }
    
    func bind(to viewModel: RecipeDetailViewModel) {
        
        viewModel.incomingRecipe = { [weak self] recipe in
            self?.recipeDetailDataSource.update(with: recipe)
            self?.recipeDescription.reloadData()
        }
        
        viewModel.recipeImage = { [weak self] image in
            self?.recipeImage.image = image
        }
        
        viewModel.isFavorite = { [weak self] state in
            switch state {
            case true:
                self?.selectedStar()
            case false:
                self?.unselectedStar()
            }

        }
    }
//        viewModel.favoriteState = { [weak self] state in
////            self?.favoriteBarItem // updtae ou appeleer une fonction qui le fait en fonction du state
//        }
    
    
    private func selectedStar() {
        let button = UIBarButtonItem(image: UIImage(named: "UnselectedStar"), style: .done, target: self, action: #selector(didPressFavorite))
        self.navigationItem.rightBarButtonItem = button
    }
    
    private func unselectedStar() {
        let button = UIBarButtonItem(image: UIImage(named: "SelectedStar"), style: .done, target: self, action: #selector(didPressFavorite))
        self.navigationItem.rightBarButtonItem = button
    }
    
    // MARK: - Actions
    
}
