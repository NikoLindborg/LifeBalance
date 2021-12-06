//
//  TrendsView.swift
//  LifeBalance
//
//  Created by iosdev on 4.12.2021.
//

import SwiftUI

struct TrendsView: View {
    
<<<<<<< Updated upstream
    // @State private var tSettings: [TrendSettings] = [TrendSettings]()
    // let persistenceController: PersistenceController

=======
    @Binding var tSettings: [TrendSettings]
    let persistenceController: PersistenceController
    
>>>>>>> Stashed changes
    @State private var ironOn = true
    @State private var caloriesOn = true
    @State private var proteinOn = true
    @State private var carbsOn = true
    @State private var sugarOn = true
    @State private var saltOn = true

    func updateSettings() {
<<<<<<< Updated upstream
       
//        tSettings[0].iron = ironOn
//        tSettings[0].calories = caloriesOn
//        tSettings[0].protein = proteinOn
//        tSettings[0].carbs = carbsOn
//        tSettings[0].sugar = sugarOn
//        tSettings[0].salt = saltOn
//        persistenceController.updateUserSettings()
=======
        persistenceController.modifyTrends(calories: caloriesOn, carbs: carbsOn, protein: proteinOn, sugar: sugarOn, salt: saltOn, iron: ironOn)
>>>>>>> Stashed changes
        
        loadSettings()
    }
    
    func loadSettings() {
<<<<<<< Updated upstream
        
//        tSettings = persistenceController.loadTrendsSettings()
//        ironOn = tSettings[0].iron
//        caloriesOn = tSettings[0].calories
//        proteinOn = tSettings[0].protein
//        carbsOn = tSettings[0].carbs
//        sugarOn = tSettings[0].sugar
//        saltOn = tSettings[0].salt
=======
                tSettings = persistenceController.getTrendSettings()
                ironOn = tSettings[0].trend_iron
                caloriesOn = tSettings[0].trend_calories
                proteinOn = tSettings[0].trend_protein
                carbsOn = tSettings[0].trend_carbs
                sugarOn = tSettings[0].trend_sugar
                saltOn = tSettings[0].trend_salt
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        TrendsView()
=======
        TrendsView(tSettings: .constant([TrendSettings]()), persistenceController: PersistenceController())
>>>>>>> Stashed changes
    }
}
