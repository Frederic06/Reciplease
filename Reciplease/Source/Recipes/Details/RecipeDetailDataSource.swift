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
    
    private var recipe: RecipeItem?
    
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
            guard let numberOfIngredient = recipe?.ingredient.count else { return 0 }
            return numberOfIngredient
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let recipe = self.recipe else {return cell}
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeName", for: indexPath)as! RecipeDetailTableViewCell
            tableView.rowHeight = 250
            cell.updateCell(with: recipe, caseType: .recipeName, row: indexPath.row)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientTitle", for: indexPath)as! RecipeDetailTableViewCell
            tableView.rowHeight = 60
            cell.updateCell(with: recipe, caseType: .ingredientTitle, row: indexPath.row)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)as! RecipeDetailTableViewCell
            tableView.rowHeight = 20
            cell.updateCell(with: recipe, caseType: .ingredientCell, row: indexPath.row)
            return cell

        default:
            print("Default Selected")
            
        }
        return cell
    }
}



