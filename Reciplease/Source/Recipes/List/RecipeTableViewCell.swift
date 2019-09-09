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
    
    private var recipe: RecipeItem? = nil {
        didSet {
            if let image = recipe?.imageURLString.transformURLToImage() {
                self.backgroundView = UIImageView(image: image)
            }
            self.recipeTitle.text = recipe?.name
            self.recipeIngredients.text = recipe?.ingredient.joined(separator: ", ")
        }
    }
    
    func updateCell(with recipe: RecipeItem) {
        self.recipe = recipe
    }
}
