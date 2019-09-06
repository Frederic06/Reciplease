//
//  RecipeDetailDataSource.swift
//  Reciplease
//
//  Created by Frédéric Blanc on 28/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

enum ReciipeItem {
    case name(String)
    case title(String)
    case ingredients(String)
}

final class RecipeDetailDataSource: NSObject, UITableViewDataSource {
    
    private var recipe: RecipeItem = RecipeItem(name: "", imageURLString: "", ingredient: [])

    enum Items {
        case name(String)
        case title(String)
        case ingredients(String)
    }

    var items: [Items] = []

    func updaate(with recipes: [ReciipeItem]) {
//        self.items = recipes.map { recipe in
//            switch recipe {
//            case .title(let title):
//                return .title(title)
//            }
//        }
    }
    
    func update (with recipe: RecipeItem) {
        self.recipe = recipe
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return recipe.ingredient.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeName", for: indexPath)
            let attributes = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 30.0)!, NSAttributedString.Key.foregroundColor: UIColor.white]
            let title = NSAttributedString(string: recipe.name, attributes: attributes)
            cell.textLabel?.attributedText = title
            cell.textLabel?.textAlignment = .center
            return cell
            
        case 1:
            let ingredientTitleCell = tableView.dequeueReusableCell(withIdentifier: "ingredientTitle", for: indexPath)
            ingredientTitleCell.textLabel?.text = "Ingredients"
            ingredientTitleCell.textLabel?.textColor = UIColor.white
            return ingredientTitleCell
            
        case 2:
            let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
            let title = recipe.ingredient[indexPath.row]
            ingredientCell.textLabel?.text = "- \(title)"
            ingredientCell.textLabel?.textColor = UIColor.white
            return ingredientCell
        default:
            print("Default Selected")
            
        }
        return cell
    }
}


