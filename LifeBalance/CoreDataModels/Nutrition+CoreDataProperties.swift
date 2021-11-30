//
//  Nutrition+CoreDataProperties.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 30.11.2021.
//
//

import Foundation
import CoreData


extension Nutrition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nutrition> {
        return NSFetchRequest<Nutrition>(entityName: "Nutrition")
    }

    @NSManaged public var label: String?
    @NSManaged public var quantity: Float
    @NSManaged public var unit: String?
    @NSManaged public var ingredient: Ingredient?

}

extension Nutrition : Identifiable {

}
