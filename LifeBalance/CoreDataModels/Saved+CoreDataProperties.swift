//
//  Saved+CoreDataProperties.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 5.12.2021.
//
//

import Foundation
import CoreData


extension Saved {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Saved> {
        return NSFetchRequest<Saved>(entityName: "Saved")
    }

    @NSManaged public var mealName: String?
    @NSManaged public var meal: Meals?

}

extension Saved : Identifiable {

}
