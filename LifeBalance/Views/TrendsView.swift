//
//  TrendsView.swift
//  LifeBalance
//
//  Created by iosdev on 4.12.2021.
//

import SwiftUI

struct TrendsView: View {
    @Binding var tSettings: [TrendSettings]
    let persistenceController: PersistenceController
    
    @State private var ironOn = true
    @State private var caloriesOn = true
    @State private var proteinOn = true
    @State private var carbsOn = true
    @State private var sugarOn = true
    @State private var saltOn = true

    func updateSettings() {
        persistenceController.modifyTrends(calories: caloriesOn, carbs: carbsOn, protein: proteinOn, sugar: sugarOn, salt: saltOn, iron: ironOn)
        loadSettings()
    }
    
    func loadSettings() {
                tSettings = persistenceController.getTrendSettings()
                ironOn = tSettings[0].trend_iron
                caloriesOn = tSettings[0].trend_calories
                proteinOn = tSettings[0].trend_protein
                carbsOn = tSettings[0].trend_carbs
                sugarOn = tSettings[0].trend_sugar
                saltOn = tSettings[0].trend_salt
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Trends")){
                    Toggle("Iron", isOn: $ironOn).onChange(of: ironOn){value in
                        print(value)
                        updateSettings()
                    }
                    Toggle("Calories", isOn: $caloriesOn).onChange(of: caloriesOn){value in
                        print(value)
                        updateSettings()
                    }
                    Toggle("Protein", isOn: $proteinOn).onChange(of: proteinOn){value in
                        print(value)
                        updateSettings()
                    }
                    Toggle("Carbs", isOn: $carbsOn).onChange(of: carbsOn){value in
                        print(value)
                        updateSettings()
                    }
                    Toggle("Sugar", isOn: $sugarOn).onChange(of: sugarOn){value in
                        print(value)
                        updateSettings()
                    }
                    Toggle("Salt", isOn: $saltOn).onChange(of: saltOn){value in
                        print(value)
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

struct TrendsView_Previews: PreviewProvider {
    static var previews: some View {
        TrendsView(tSettings: .constant([TrendSettings]()), persistenceController: PersistenceController())
    }
}
