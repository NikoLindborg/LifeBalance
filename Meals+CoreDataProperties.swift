//
//  Meals+CoreDataProperties.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 29.11.2021.
//
//

import Foundation
import CoreData


extension Meals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meals> {
        return NSFetchRequest<Meals>(entityName: "Meals")
    }

    @NSManaged public var mealType: String?
    @NSManaged public var relationship: Day?

}

extension Meals : Identifiable {

}
