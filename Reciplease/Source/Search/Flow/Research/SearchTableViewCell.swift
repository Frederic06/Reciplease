//
//  SearchDataSource.swift
//  Reciplease
//
//  Created by Margarita Blanc on 19/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    func updateCell(with ingredients: [String], row: Int) {
        let title = ingredients[row]
        ingredientLabel.text =  "- \(title)"
    }
}
