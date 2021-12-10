//
//  Saved+CoreDataProperties.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 8.12.2021.
//
//

import Foundation
import CoreData


extension Saved {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Saved> {
        return NSFetchRequest<Saved>(entityName: "Saved")
    }

    @NSManaged public var mealName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var ingredients: NSSet?

}

// MARK: Generated accessors for ingredients
extension Saved {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

extension Saved : Identifiable {

}
