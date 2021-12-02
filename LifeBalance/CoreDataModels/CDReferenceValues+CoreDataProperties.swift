//
//  CDReferenceValues+CoreDataProperties.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 1.12.2021.
//
//

import Foundation
import CoreData


extension CDReferenceValues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDReferenceValues> {
        return NSFetchRequest<CDReferenceValues>(entityName: "CDReferenceValues")
    }

    @NSManaged public var ref_calories: Double
    @NSManaged public var ref_iron: Double

}

extension CDReferenceValues : Identifiable {

}
