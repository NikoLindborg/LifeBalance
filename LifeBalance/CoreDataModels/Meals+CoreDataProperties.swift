//
//  Meals+CoreDataProperties.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 30.11.2021.
//
//

import Foundation
import CoreData


extension Meals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meals> {
        return NSFetchRequest<Meals>(entityName: "Meals")
    }

    @NSManaged public var mealType: String?
    @NSManaged public var day: Day?
    @NSManaged public var ingredients: NSSet?

}

// MARK: Generated accessors for ingredients
extension Meals {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

extension Meals : Identifiable {

}
