//
//  Alert.swift
//  Reciplease
//
//  Created by Margarita Blanc on 18/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

enum AlertType {
    case networkError, noRecipes, noIngredient
}

struct Alert {
    let title: String
    let message: String
}

extension Alert {
    init(type: AlertType) {
        switch type {
        case .networkError:
            self = Alert(title: "Alert", message: "A very very bad thing happened.. network error 😱")
        case .noRecipes:
            self = Alert(title: "Alert", message: """
No recipe found.. 😢
Add some recipe clicking on the star on the recipe detail view 👏
""")
        case .noIngredient:
            self = Alert(title: "Alert", message: "Please enter at least one ingredient.. ☝️")
        }
    }
}

protocol AlertDelegate: class {
    func displayAlert(type: AlertType)
}
