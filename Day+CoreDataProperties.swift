//
//  Day+CoreDataProperties.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 23.11.2021.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var date: String
}

extension Day : Identifiable {

}
