//
//  HealthKit.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 24.11.2021.
//

import Foundation
import HealthKit
import SwiftUI

class HealthKit: ObservableObject {
    @Published var burntCalories: String = "0"
    @Published var healthData: Bool = false
    @Published var dataArray: Array<DataArrayItem> = []
    @Published var max: Double = 0.0
    var arrayForMax: Array<Double> = []

    let healthStore = HKHealthStore()

    func authorizeHealthStore() {
        let read = Set([HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!])
        let share = Set([HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!])

        healthStore.requestAuthorization(toShare: share, read: read) { success, error in
            if (success) {
                print("permission granted")
                self.getActiveCalories()
                self.getActiveCaloriesForLastWeek()
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
                DispatchQueue.main.async {
                    self.burntCalories = String(data.quantity.doubleValue(for: unit))
                    print("burned in healthkit class \(self.burntCalories)")
                    self.healthData = true
                  }
            }
        }
        healthStore.execute(query)
    }
    
    func getActiveCaloriesForLastWeek() {
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            fatalError("Unable to fetch active energy")
        }
        
        var interval = DateComponents()
        interval.hour = 24
        
        let calendar = Calendar.current
        let anchorDate = calendar.date(bySettingHour: 2, minute: 0, second: 0, of: Date()) ?? Date()
        let startDate = calendar.date(byAdding: .day, value: -6, to: Date()) ?? Date()
        let unit = HKUnit(from: "Cal")
        
        let query = HKStatisticsCollectionQuery
            .init(quantityType: stepCountType,
                  quantitySamplePredicate: nil,
                  options: .cumulativeSum,
                  anchorDate: anchorDate,
                  intervalComponents: interval)
        
        query.initialResultsHandler = {query, results, error in
            DispatchQueue.main.async {
                results?.enumerateStatistics(from: startDate,
                                             to: Date(), with: { (result, stop) in
                    print("Time: \(result.startDate), \(result.sumQuantity()?.doubleValue(for: unit) ?? 0)")
                    self.dataArray.append(DataArrayItem(data: result.sumQuantity()?.doubleValue(for: unit) ?? 0))
                    self.arrayForMax.append(result.sumQuantity()?.doubleValue(for: unit) ?? 0)
                    self.max = self.arrayForMax.max() ?? 0.0
                })
            }
        }
        healthStore.execute(query)
    }
}

struct DataArrayItem: Identifiable {
    var id = UUID()
    var data: Double
}
