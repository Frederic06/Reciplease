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
    
    @IBOutlet weak var directionButton: UIButton!
    
    // MARK: - Properties
    var viewModel: RecipeDetailViewModel!
    
    private lazy var recipeDetailDataSource = RecipeDetailDataSource()
    
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
        setStar(favorite: true)
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
            self?.setStar(favorite: state)
        }
        
        viewModel.recipeButton = { [weak self] text in
            self?.directionButton.setTitle(text, for: .normal)
        }
    }
    
    private func setStar(favorite: Bool) {
        guard let selectedStar = UIImage(named: "selectedStar") else { return }
        guard let unselectedStar = UIImage(named: "unselectedStar") else { return }
        var star: UIImage
        
        switch favorite {
        case true:
            star = selectedStar
        case false:
            star = unselectedStar
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: star, style: .done, target: self, action: #selector(didPressFavorite))
    }
    // MARK: - Actions
    
    @IBAction func getDirectionsButton(_ sender: UIButton) {
        viewModel.clickedOnDirectionButton()
    }
    
}
