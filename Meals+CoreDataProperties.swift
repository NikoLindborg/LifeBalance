//
//  Meals+CoreDataProperties.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 5.12.2021.
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
    @NSManaged public var saved: NSSet?

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

// MARK: Generated accessors for saved
extension Meals {

    @objc(addSavedObject:)
    @NSManaged public func addToSaved(_ value: Saved)

    @objc(removeSavedObject:)
    @NSManaged public func removeFromSaved(_ value: Saved)

    @objc(addSaved:)
    @NSManaged public func addToSaved(_ values: NSSet)

    @objc(removeSaved:)
    @NSManaged public func removeFromSaved(_ values: NSSet)

}

extension Meals : Identifiable {

}
