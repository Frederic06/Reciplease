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

    private lazy var favoriteBarItem: UIBarButtonItem = {
        let button = UIButton(type: .infoLight)
        button.addTarget(self, action: #selector(didPressFavorite), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }()
    
    private lazy var button: UIBarButtonItem = {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressFavorite))
        return add
    }()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        configureUI()
        
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
        self.navigationItem.rightBarButtonItem = button
        
        
        //        let infoButton = UIButton(type: .infoLight)
        //        infoButton.addTarget(self, action: #selector(nil), for: .touchUpInside)
        //        let barButton = UIBarButtonItem(customView: infoButton)
        //        presenter.navigationItem.rightBarButtonItem = barButton
        //        presenter.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }
    
    func bind(to viewModel: RecipeDetailViewModel) {
        
        viewModel.incomingRecipe = { [weak self] recipe in
            self?.recipeDetailDataSource.update(with: recipe)
            self?.recipeDescription.reloadData()
        }
        
        viewModel.recipeImage = { [weak self] image in
            self?.recipeImage.image = image
        }

//        viewModel.favoriteState = { [weak self] state in
////            self?.favoriteBarItem // updtae ou appeleer une fonction qui le fait en fonction du state
//        }
    }
    
    // MARK: - Actions
    
}
