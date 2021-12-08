//
//  CDReferenceValues+CoreDataProperties.swift
//  LifeBalance
//
//  Created by iosdev on 7.12.2021.
//
//

import Foundation
import CoreData


extension CDReferenceValues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDReferenceValues> {
        return NSFetchRequest<CDReferenceValues>(entityName: "CDReferenceValues")
    }

    @NSManaged public var ref_calories: Double
    @NSManaged public var ref_carbohydrates: Double
    @NSManaged public var ref_fat: Double
    @NSManaged public var ref_fiber: Double
    @NSManaged public var ref_iron: Double
    @NSManaged public var ref_protein: Double
    @NSManaged public var ref_sodium: Double
    @NSManaged public var ref_sugar: Double

}

extension CDReferenceValues : Identifiable {

}
