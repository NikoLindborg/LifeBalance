//
//  TrendsView.swift
//  LifeBalance
//
//  Created by iosdev on 4.12.2021.
//
/*
 A view for selecting the trends based on user wants to be displayed on the HomeView.
 
 Settings are updated to CoreData via persistenceController.
 */

import SwiftUI

struct TrendsView: View {
    @Binding var tSettings: TrendSettings
    let persistenceController: PersistenceController
    
    @State private var ironOn = true
    @State private var caloriesOn = true
    @State private var proteinOn = true
    @State private var carbsOn = true
    @State private var sugarOn = true
    @State private var saltOn = true

    // This function saves the updated trend settings to CoreData
    func updateSettings() {
        persistenceController.modifyTrends(calories: caloriesOn, carbs: carbsOn, protein: proteinOn, sugar: sugarOn, salt: saltOn, iron: ironOn)
        loadSettings()
        $tSettings.wrappedValue = persistenceController.getTrendSettings()[0]
    }
    
    func loadSettings() {
        ironOn = tSettings.trend_iron
        caloriesOn = tSettings.trend_calories
        proteinOn = tSettings.trend_protein
        carbsOn = tSettings.trend_carbs
        sugarOn = tSettings.trend_sugar
        saltOn = tSettings.trend_salt
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Trends")){
                    Toggle("Iron", isOn: $ironOn).onChange(of: ironOn){value in
                        updateSettings()
                    }
                    Toggle("Calories", isOn: $caloriesOn).onChange(of: caloriesOn){value in
                        updateSettings()
                    }
                    Toggle("Protein", isOn: $proteinOn).onChange(of: proteinOn){value in
                        updateSettings()
                    }
                    Toggle("Carbs", isOn: $carbsOn).onChange(of: carbsOn){value in
                        updateSettings()
                    }
                    Toggle("Sugar", isOn: $sugarOn).onChange(of: sugarOn){value in
                        updateSettings()
                    }
                    Toggle("Salt", isOn: $saltOn).onChange(of: saltOn){value in
                        updateSettings()
                    }
                }
        
            }
            .navigationTitle("Trends")
            .onAppear(perform: {
                loadSettings()
            })
        }
    }
}
