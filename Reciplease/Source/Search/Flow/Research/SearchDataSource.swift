//
//  IngredientListTableDataSource.swift
//  Reciplease
//
//  Created by Frédéric Blanc on 24/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class SearchDataSource: NSObject, UITableViewDataSource {
    
    private var ingredients: [String] = []
    
    func update(with ingredients: [String]) {
        self.ingredients = ingredients
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 50
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)as! SearchTableViewCell
        cell.updateCell(with: ingredients, row: indexPath.row)
        return cell
    }
}
