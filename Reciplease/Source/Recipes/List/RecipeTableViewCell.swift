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
 
    @IBOutlet weak var recipeImage: UIImageView!

    @IBOutlet weak var gradientView: GradientView!
    
    private var recipe: RecipeItem? = nil {
        didSet {
            if let image = recipe?.imageURLString.transformURLToImage() {
                self.recipeImage.image = image
            }
            self.recipeTitle.text = recipe?.name
            self.recipeIngredients.text = recipe?.ingredient.joined(separator: ", ")

        }
    }
    @IBAction func didPressFavoriteStarButton(_ sender: UIButton) {
    }
    
    func updateCell(with recipe: RecipeItem) {
        self.recipe = recipe
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        recipeTitle.text = nil
        recipeIngredients.text = nil
        recipeImage.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradientView()
    }

    private func setupGradientView() {
        let endColor = UIColor.black
        let startColor = UIColor.clear
        gradientView.updateGradient(with: .vertical, colors: startColor, endColor)
    }
}

final class GradientView: UIView {

    lazy var gradientLayer = layer as? LinearGradientLayer

    override class var layerClass: AnyClass {
        return LinearGradientLayer.self
    }

    func updateGradient(with direction: LinearGradientLayer.Direction, colors: UIColor...) {
        gradientLayer?.direction = direction
        gradientLayer?.colors = colors.map { $0.cgColor}
        gradientLayer?.setNeedsDisplay()
    }
}
