//
//  RecipeObject+CoreDataProperties.swift
//  
//
//  Created by Margarita Blanc on 05/09/2019.
//
//

import Foundation
import CoreData


extension RecipeObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeObject> {
        return NSFetchRequest<RecipeObject>(entityName: "RecipeObject")
    }

    @NSManaged public var recipeImage: String?
    @NSManaged public var recipeIngredients: NSObject?
    @NSManaged public var recipeName: String?

}
