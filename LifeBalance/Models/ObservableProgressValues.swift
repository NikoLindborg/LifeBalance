//
//  ObservableProgressValues.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 12.12.2021.
//

/**
 Observable class made for ProgressItem, made so views properly react to "state" change.
 */

import Foundation

class ObservableProgressValues: ObservableObject {
    let persistenceController = PersistenceController()
    @Published var ironConsumed: Float = 0.0
    @Published var carbsConsumed: Float = 0.0
    @Published var caloriesConsumed: Float = 0.0
    @Published var proteinConsumed: Float = 0.0
    @Published var sugarConsumed: Float = 0.0
    @Published var saltConsumed: Float = 0.0
    @Published var ironTarget: Float = 0.0
    @Published var carbsTarget: Float = 0.0
    @Published var caloriesTarget: Float = 0.0
    @Published var proteinTarget: Float = 0.0
    @Published var sugarTarget: Float = 0.0
    @Published var saltTarget: Float = 0.0
    var fullProgressValues: Array<ProgressItem> = []
    var fullProgressValuesYesterday: Array<ProgressItem> = []
    var fullProgressValuesdayBeforeYesterday: Array<ProgressItem> = []
    var allProgressValues: Array<Array<ProgressItem>> = []
    let dayBeforeYesterday = itemFormatter.string(from: Calendar.current.date(byAdding: .day, value: -2, to: Date())!)
    let yesterday = itemFormatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
    let today = itemFormatter.string(from: Date())
    
    
    func update() {
        ironTarget = 0
        ironConsumed = 0
        carbsTarget = 0
        carbsConsumed = 0
        caloriesTarget = 0
        caloriesConsumed = 0
        proteinTarget = 0
        proteinConsumed = 0
        sugarTarget = 0
        sugarConsumed = 0
        saltTarget = 0
        saltConsumed = 0
        allProgressValues.removeAll()
        self.fullProgressValues = persistenceController.getProgressValues(nil, date: today)
        self.fullProgressValuesYesterday = persistenceController.getProgressValues(nil, date: yesterday)
        self.fullProgressValuesdayBeforeYesterday = persistenceController.getProgressValues(nil, date: dayBeforeYesterday)
        allProgressValues.append(fullProgressValues)
        allProgressValues.append(fullProgressValuesYesterday)
        allProgressValues.append(fullProgressValuesdayBeforeYesterday)
        setValues()
    }
    
    func setValues() {
        for e in self.allProgressValues {
            for item in e{
                if(item.description == "iron"){
                    ironTarget += item.target
                    ironConsumed += item.consumed
                }
                if(item.description == "carbs"){
                    carbsTarget += item.target
                    carbsConsumed += item.consumed
                }
                if(item.description == "calories"){
                    caloriesTarget += item.target
                    caloriesConsumed += item.consumed
                }
                if(item.description == "protein"){
                    proteinTarget += item.target
                    proteinConsumed += item.consumed
                }
                if(item.description == "sugar"){
                    sugarTarget += item.target
                    sugarConsumed += item.consumed
                }
                if(item.description == "sodium"){
                    saltTarget += item.target
                    saltConsumed += item.consumed
                }
            }
            
        }
    }
    
}
