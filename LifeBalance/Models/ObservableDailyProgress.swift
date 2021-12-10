//
//  ObservableDailyProgress.swift
//  LifeBalance
//
//  Created by iosdev on 8.12.2021.
//
import Foundation

class ObservableDailyProgress: ObservableObject {
    @Published var dailyProgress: [DailyProgressCoreData] = []
    let persistenceController = PersistenceController()
    let today = itemFormatter.string(from: Date())
    @Published var progressValues: Array<ProgressItem> = []
    
    func update(){
        self.dailyProgress = persistenceController.getDailyProgressCoreData()
    }
    
    func fetchList() {
        self.update()
        var l :[String] = []
        if(!dailyProgress.isEmpty){
            if(dailyProgress[0].daily_fat) {
                l.append("fat")
            }
            if(dailyProgress[0].daily_carbs) {
                l.append("carbs")
            }
            if(dailyProgress[0].daily_sodium) {
                l.append("sodium")
            }
            if(dailyProgress[0].daily_iron) {
                l.append("iron")
            }
            if(dailyProgress[0].daily_sugar) {
                l.append("sugar")
            }
            if(dailyProgress[0].daily_calories) {
                l.append("calories")
            }
            if(dailyProgress[0].daily_protein) {
                l.append("protein")
            }
        }
        progressValues = persistenceController.getProgressValues(l, date: today)
    }
    
}

