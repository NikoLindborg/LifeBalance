//
//  HealthKit.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 24.11.2021.
//

import Foundation
import HealthKit

class HealthKit: ObservableObject {
    @Published var burntCalories: String = "0"
    @Published var healthData: Bool = false
    let healthStore = HKHealthStore()

    func authorizeHealthStore() {
        let read = Set([HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!])
        let share = Set([HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!])

        healthStore.requestAuthorization(toShare: share, read: read) { success, error in
            if (success) {
                print("permission granted")
                self.getActiveCalories()
            }
        }
    }
    
    func getActiveCalories() {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            return
        }
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) { sample, result, error in
            guard error == nil else {
                return
            }
            
            if (result?.count != 0) {
                let unit = HKUnit(from: "Cal")
                let data = result![0] as! HKQuantitySample
                //print("Todays active calories: \(data.quantity.doubleValue(for: unit))")
                //message = String(data.quantity.doubleValue(for: unit))
                //self.burntCalories = String(data.quantity.doubleValue(for: unit))
                DispatchQueue.main.async {
                    self.burntCalories = String(data.quantity.doubleValue(for: unit))
                    print("burned in healthkit class \(self.burntCalories)")
                    self.healthData = true
                  }
            }
        }
        healthStore.execute(query)
    }
}
