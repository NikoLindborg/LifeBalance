//
//  TrendSettings+CoreDataProperties.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 5.12.2021.
//
//

import Foundation
import CoreData


extension TrendSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrendSettings> {
        return NSFetchRequest<TrendSettings>(entityName: "TrendSettings")
    }

    @NSManaged public var calories: Bool
    @NSManaged public var carbs: Bool
    @NSManaged public var iron: Bool
    @NSManaged public var protein: Bool
    @NSManaged public var salt: Bool
    @NSManaged public var sugar: Bool

}

extension TrendSettings : Identifiable {

}
