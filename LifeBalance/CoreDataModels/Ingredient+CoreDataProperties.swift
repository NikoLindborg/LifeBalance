//
//  Ingredient+CoreDataProperties.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 30.11.2021.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var foodId: String?
    @NSManaged public var label: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var nutrients: NSSet?
    @NSManaged public var meal: Meals?

}

// MARK: Generated accessors for nutrients
extension Ingredient {

    @objc(addNutrientsObject:)
    @NSManaged public func addToNutrients(_ value: Nutrition)

    @objc(removeNutrientsObject:)
    @NSManaged public func removeFromNutrients(_ value: Nutrition)

    @objc(addNutrients:)
    @NSManaged public func addToNutrients(_ values: NSSet)

    @objc(removeNutrients:)
    @NSManaged public func removeFromNutrients(_ values: NSSet)

}

extension Ingredient : Identifiable {

}
