//
//  ObservableActivity.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 7.12.2021.
//
/*
 Model for observing the HealthKit data on the HomeView without any
 rendering issues. Data is fetched from HealthKit and passed as an ObservableObject, which
 can be read on the ChartCard
 */

import Foundation
import SwiftUI

class ObservableActivity: ObservableObject {
    @Published var healthKitActivityArray: [[CGFloat]]
    @Published var healthKitStepsArray: [[CGFloat]]
    @Published var healthKitMaxActivity: Double
    @Published var healthKitMaxSteps: Double
    @Published var weekdays: Array<String>
    @Published var healthData: Bool
    var healthKit = HealthKit()

    init(){
        self.healthKitActivityArray = healthKit.activityData
        self.healthKitStepsArray = healthKit.stepData
        self.healthKitMaxActivity = healthKit.maxActivity
        self.healthKitMaxSteps = healthKit.maxSteps
        self.weekdays = healthKit.weekdays
        self.healthData = healthKit.healthData
    }
    
    // Via this method the data is saved to this ObservableObject in other views. 
    func update(activityData: [[CGFloat]], stepData: [[CGFloat]], maxActivity: Double, maxSteps: Double, weekdays: Array<String>, healthData: Bool) {
        print("Update")
        self.healthKitActivityArray = activityData
        self.healthKitStepsArray = stepData
        self.healthKitMaxActivity = maxActivity
        self.healthKitMaxSteps = maxSteps
        self.weekdays = weekdays
        self.healthData = healthData
    }
}
