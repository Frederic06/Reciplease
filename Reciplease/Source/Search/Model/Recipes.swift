//
//  Recipes.swift
//  Reciplease
//
//  Created by Frédéric Blanc on 24/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

struct Recipes: Decodable {

    let hits: [Hit]

    struct Hit: Decodable {
        let recipe: RecipeProperties
    }

    struct RecipeProperties: Decodable {
        let label: String
        let image: String
        let ingredientLines: [String]
    }
}
