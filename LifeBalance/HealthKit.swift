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
    @Published var stepArray: Array<DataArrayItem> = []
    @Published var activityData: [[CGFloat]] = [[]]
    @Published var stepData: [[CGFloat]] = [[]]
    @Published var maxActivity: Double = 0.0
    @Published var maxSteps: Double = 0.0
    @Published var weekdays: Array<String> = []
    var arrayForMax: Array<Double> = []
    var arrayForMaxSteps: Array<Double> = []

    let healthStore = HKHealthStore()

    func authorizeHealthStore() {
        if (!healthData) {
            let read = Set([HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!, HKObjectType.quantityType(forIdentifier: .stepCount)!])
            let share = Set([HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!])

            healthStore.requestAuthorization(toShare: share, read: read) { success, error in
                if (success) {
                    print("permission granted")
                    self.getActiveCaloriesForLastWeek()
                    self.getStepCount()
                    self.getActiveCalories()
                }
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
                    self.healthData = true
                  }
            }
        }
        
        DispatchQueue.main.async {
            let format = DateFormatter()
            format.dateFormat = "EEE"
            for n in 0...6 {
                let today = Calendar.current.date(byAdding: .day, value: -n, to: Date())!
                self.weekdays.append(format.string(from: today))
            }
            self.weekdays = self.weekdays.reversed()
        }
        
        healthStore.execute(query)
    }
    
    func getActiveCaloriesForLastWeek() {
        guard let objectType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            fatalError("Unable to fetch active energy")
        }

        var interval = DateComponents()
        interval.hour = 24
        
        let calendar = Calendar.current
        let anchorDate = calendar.date(bySettingHour: 2, minute: 0, second: 0, of: Date()) ?? Date()
        let startDate = calendar.date(byAdding: .day, value: -6, to: Date()) ?? Date()
        let unit = HKUnit(from: "Cal")
        
        let query = HKStatisticsCollectionQuery
            .init(quantityType: objectType,
                  quantitySamplePredicate: nil,
                  options: .cumulativeSum,
                  anchorDate: anchorDate,
                  intervalComponents: interval)
        
        query.initialResultsHandler = {query, results, error in
            DispatchQueue.main.async {
                results?.enumerateStatistics(from: startDate,
                                             to: Date(), with: { (result, stop) in
                    self.dataArray.append(DataArrayItem(data: result.sumQuantity()?.doubleValue(for: unit) ?? 0))
                    self.arrayForMax.append(result.sumQuantity()?.doubleValue(for: unit) ?? 0)
                    self.maxActivity = self.arrayForMax.max() ?? 0.0
                    if (self.maxActivity > 0.0) {
                        self.healthData = true
                    }
                })
                var firstArray: [CGFloat] = []
                self.dataArray.forEach {data in
                    firstArray.append(data.data)
                }
                self.activityData.append(firstArray)
                self.activityData.remove(at: 0)
            }
        }
        healthStore.execute(query)
    }
    
    func getStepCount() {
        guard let objectType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            fatalError("Unable to fetch stepcount")
        }

        var interval = DateComponents()
        interval.hour = 24
        
        let calendar = Calendar.current
        let anchorDate = calendar.date(bySettingHour: 2, minute: 0, second: 0, of: Date()) ?? Date()
        let startDate = calendar.date(byAdding: .day, value: -6, to: Date()) ?? Date()
        
        let query = HKStatisticsCollectionQuery
            .init(quantityType: objectType,
                  quantitySamplePredicate: nil,
                  options: .cumulativeSum,
                  anchorDate: anchorDate,
                  intervalComponents: interval)
        
        query.initialResultsHandler = {query, results, error in
            DispatchQueue.main.async {
                results?.enumerateStatistics(from: startDate,
                                             to: Date(), with: { (result, stop) in
                    self.stepArray.append(DataArrayItem(data: result.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0))
                    self.arrayForMaxSteps.append(result.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0)
                    self.maxSteps = self.arrayForMaxSteps.max() ?? 0.0
                    if (self.maxSteps > 0.0) {
                        self.healthData = true
                    }
                })
                var firstArray: [CGFloat] = []
                self.stepArray.forEach {data in
                    firstArray.append(data.data)
                }
                self.stepData.append(firstArray)
                self.stepData.remove(at: 0)
            }
        }
        healthStore.execute(query)
    }
}

struct DataArrayItem: Identifiable {
    var id = UUID()
    var data: Double
}
