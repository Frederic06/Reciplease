//
//  IngredientListTableDataSource.swift
//  Reciplease
//
//  Created by Frédéric Blanc on 24/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class IngredientListTableDataSource: NSObject, UITableViewDataSource {
    
    private var ingredient: [String] = []
    
    func update(with countryItem: [String]) {
        self.ingredient = countryItem
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredient.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        let title = ingredient[indexPath.row]
        cell.textLabel?.text = title
        return cell
    }
}
