//
//  DailyProgressView.swift
//  LifeBalance
//
//  Created by iosdev on 8.12.2021.
//

import SwiftUI

struct DailyProgressView: View {
    @Binding var dailyProgressSettings : DailyProgressCoreData
    let persistenceController: PersistenceController
    @ObservedObject var observedDailyProgress: ObservableDailyProgress
    
    @State private var ironOn = true
    @State private var caloriesOn = true
    @State private var proteinOn = true
    @State private var carbsOn = true
    @State private var sugarOn = true
    @State private var sodiumOn = true
    @State private var fatOn = true
    @State private var toggleAmount = 0
    
    func updateSettings() {
        persistenceController.modifyDailyProgress(calories: caloriesOn, carbs: carbsOn, protein: proteinOn, sugar: sugarOn, salt: sodiumOn, iron: ironOn, fat: fatOn)
        $dailyProgressSettings.wrappedValue = persistenceController.getDailyProgressCoreData()[0]
    }
    
    func loadSettings() {
        toggleAmount = 0
        ironOn = dailyProgressSettings.daily_iron
        caloriesOn = dailyProgressSettings.daily_calories
        proteinOn = dailyProgressSettings.daily_protein
        carbsOn = dailyProgressSettings.daily_carbs
        sugarOn = dailyProgressSettings.daily_sugar
        sodiumOn = dailyProgressSettings.daily_sodium
        fatOn = dailyProgressSettings.daily_fat
        if(ironOn){
            toggleAmount += 1
        }
        if(caloriesOn){
            toggleAmount += 1
        }
        if(proteinOn){
            toggleAmount += 1
        }
        if(carbsOn){
            toggleAmount += 1
        }
        if(sugarOn){
            toggleAmount += 1
        }
        if(sodiumOn){
            toggleAmount += 1
        }
        if(fatOn){
            toggleAmount += 1
        }
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Daily progress")){
                    Toggle("Iron", isOn: $ironOn).onChange(of: ironOn ){value in
                        print(value)
                        if(toggleAmount < 4){
                            updateSettings()
                        }else if(toggleAmount >= 4){
                            ironOn = false
                            updateSettings()
                        }
                        loadSettings()
                    }
                    Toggle("Calories", isOn: $caloriesOn).onChange(of: caloriesOn){value in
                        print(value)
                        if(toggleAmount < 4){
                            updateSettings()
                        }else if(toggleAmount >= 4){
                            caloriesOn = false
                            updateSettings()
                        }
                        loadSettings()
                    }
                    Toggle("Protein", isOn: $proteinOn).onChange(of: proteinOn){value in
                        print(value)
                        if(toggleAmount < 4){
                            updateSettings()
                        }else if(toggleAmount >= 4){
                            proteinOn = false
                            updateSettings()                        }
                        loadSettings()
                    }
                    Toggle("Carbs", isOn: $carbsOn).onChange(of: carbsOn){value in
                        print(value)
                        if(toggleAmount < 4){
                            updateSettings()
                        }else if(toggleAmount >= 4){
                            carbsOn = false
                            updateSettings()
                        }
                        loadSettings()
                    }
                    Toggle("Sugar", isOn: $sugarOn).onChange(of: sugarOn){value in
                        print(value)
                        if(toggleAmount < 4){
                            updateSettings()
                        }else if(toggleAmount >= 4){
                            sugarOn = false
                            updateSettings()
                        }
                        loadSettings()
                    }
                    Toggle("Salt", isOn: $sodiumOn).onChange(of: sodiumOn){value in
                        print(value)
                        if(toggleAmount < 4){
                            updateSettings()
                        }else if(toggleAmount >= 4){
                            sodiumOn = false
                            updateSettings()
                        }
                        loadSettings()
                    }
                    Toggle("Fat", isOn: $fatOn).onChange(of: fatOn){value in
                        print(value)
                        if(toggleAmount < 4){
                            updateSettings()
                        }else if(toggleAmount >= 4){
                            fatOn = false
                            updateSettings()
                        }
                        loadSettings()
                    }
                }
            }
            .navigationTitle("Daily Progress")
            .onAppear(perform: {
                loadSettings()
            })
            .onDisappear(perform: observedDailyProgress.fetchList)
        }
    }
}
    /*
    struct DailyProgressView_Previews: PreviewProvider {
        static var previews: some View {
            DailyProgressView(dailyProgressSettings: .constant(DailyProgressCoreData()), persistenceController: PersistenceController())
        }
    }*/
