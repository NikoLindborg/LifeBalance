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

    @NSManaged public var date: Date
    @NSManaged public var meal: String
    
    var mealName: Meals {
            set {
                meal = newValue.rawValue
            }
            get {
                Meals(rawValue: meal) ?? .breakfast
            }
        }
}

extension Day : Identifiable {

}

enum Meals: String {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"
}
