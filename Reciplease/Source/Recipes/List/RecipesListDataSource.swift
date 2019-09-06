//
//  RecipeDataSource.swift
//  Reciplease
//
//  Created by Margarita Blanc on 26/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit




final class RecipesListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    
    private var recipes: [RecipeItem] = []
    var didSelectRecipe: ((RecipeItem) -> Void)?
    
    func update (foundRecipes: [RecipeItem]) {
        self.recipes = foundRecipes
    }
    
    // MARK: - DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)as! RecipeTableViewCell
        cell.updateCell(with: recipes[indexPath.row])
        return cell
    }
    
    // MARK: - Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // didPressItemAtIndex
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < recipes.count else { return }
        didSelectRecipe?(recipes[indexPath.row])
    }
}
