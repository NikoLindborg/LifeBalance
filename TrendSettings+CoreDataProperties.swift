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

    @NSManaged public var trend_calories: Bool
    @NSManaged public var trend_carbs: Bool
    @NSManaged public var trend_iron: Bool
    @NSManaged public var trend_protein: Bool
    @NSManaged public var trend_salt: Bool
    @NSManaged public var trend_sugar: Bool

}

extension TrendSettings : Identifiable {

}
