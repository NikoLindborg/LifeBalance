//
//  Ingredient+CoreDataProperties.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 8.12.2021.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var foodId: String?
    @NSManaged public var identifier: UUID?
    @NSManaged public var label: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var meal: Meals?
    @NSManaged public var nutrients: NSSet?
    @NSManaged public var saved: Saved?

}

// MARK: Generated accessors for nutrients
extension Ingredient {

    @objc(insertObject:inNutrientsAtIndex:)
    @NSManaged public func insertIntoNutrients(_ value: Nutrition, at idx: Int)

    @objc(removeObjectFromNutrientsAtIndex:)
    @NSManaged public func removeFromNutrients(at idx: Int)

    @objc(insertNutrients:atIndexes:)
    @NSManaged public func insertIntoNutrients(_ values: [Nutrition], at indexes: NSIndexSet)

    @objc(removeNutrientsAtIndexes:)
    @NSManaged public func removeFromNutrients(at indexes: NSIndexSet)

    @objc(replaceObjectInNutrientsAtIndex:withObject:)
    @NSManaged public func replaceNutrients(at idx: Int, with value: Nutrition)

    @objc(replaceNutrientsAtIndexes:withNutrients:)
    @NSManaged public func replaceNutrients(at indexes: NSIndexSet, with values: [Nutrition])

    @objc(addNutrientsObject:)
    @NSManaged public func addToNutrients(_ value: Nutrition)

    @objc(removeNutrientsObject:)
    @NSManaged public func removeFromNutrients(_ value: Nutrition)

    @objc(addNutrients:)
    @NSManaged public func addToNutrients(_ values: NSOrderedSet)

    @objc(removeNutrients:)
    @NSManaged public func removeFromNutrients(_ values: NSOrderedSet)

}

extension Ingredient : Identifiable {

}
