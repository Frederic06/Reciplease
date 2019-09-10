//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Frédéric Blanc on 30/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit


final class RecipeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var recipeTitle: UILabel!
    
    @IBOutlet weak var recipeIngredients: UILabel!
 
    private let selectedStar = UIImage(named: "selectedStar")
    
    private let unSelectedStar = UIImage(named: "unSelectedStar")
    
    private var recipe: RecipeItem? = nil {
        didSet {
            if let image = recipe?.imageURLString.transformURLToImage() {
                self.backgroundView = UIImageView(image: image)
            }
            self.recipeTitle.text = recipe?.name
            self.recipeIngredients.text = recipe?.ingredient.joined(separator: ", ")

        }
    }
    @IBAction func didPressFavoriteStarButton(_ sender: UIButton) {
    }
    
    func updateCell(with recipe: RecipeItem) {
        self.recipe = recipe
    }
}
