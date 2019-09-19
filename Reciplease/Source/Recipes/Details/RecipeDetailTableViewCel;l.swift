//
//  RecipeDetailTableViewCel;l.swift
//  Reciplease
//
//  Created by Margarita Blanc on 18/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

enum cellCase {
    case recipeName, ingredientTitle, ingredientCell
}

final class RecipeDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    
    @IBOutlet weak var ingredientTitle: UILabel!
    
    private var recipe: RecipeItem?
    
    private var row: Int?
    
    func updateCell(with recipe: RecipeItem, caseType: cellCase, row: Int) {
        self.recipe = recipe
        self.row = row
        
        switch caseType {
        case .recipeName:
            updateRecipeNameCell()
        case .ingredientTitle:
            updateIngredientTitleCell()
        case .ingredientCell:
            updateIngredientCell()
        }
    }
    
    func updateRecipeNameCell() {
        guard let recipeName = recipe?.name else { return }
        recipeTitleLabel.text = recipeName
    }
    
    func updateIngredientTitleCell() {
        ingredientTitle?.text = "Ingredients :"
    }
    
    func updateIngredientCell() {
        guard let row = row else { return }
        guard let recipeIngredient = recipe?.ingredient[row] else { return }
        let attributes = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 15.0)! ]
        textLabel?.attributedText = NSAttributedString(string: "-\(recipeIngredient)", attributes: attributes)
        textLabel?.textColor = UIColor.white
    }
}
