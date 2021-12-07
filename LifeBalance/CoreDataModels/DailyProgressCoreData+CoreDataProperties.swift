//
//  DailyProgressCoreData+CoreDataProperties.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 5.12.2021.
//
//

import Foundation
import CoreData


extension DailyProgressCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyProgressCoreData> {
        return NSFetchRequest<DailyProgressCoreData>(entityName: "DailyProgressCoreData")
    }

    @NSManaged public var daily_protein: Bool
    @NSManaged public var daily_iron: Bool
    @NSManaged public var daily_sugar: Bool
    @NSManaged public var daily_sodium: Bool
    @NSManaged public var daily_calories: Bool
    @NSManaged public var daily_fat: Bool
    @NSManaged public var daily_carbs: Bool

}

extension DailyProgressCoreData : Identifiable {

}
