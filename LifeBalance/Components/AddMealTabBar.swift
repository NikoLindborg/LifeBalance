//
//  AddMealTabBar.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 23.11.2021.
//

import SwiftUI

struct AddMealTabBar: View {
    @State var selectedTab: Int = 0
    @Binding var addedFoods: [FoodModel]
    @State var query = ""
    let persistenceController: PersistenceController
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                Text("Add new").tag(0)
                Text("My foods").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            switch(selectedTab) {
            case 0:
                AddNewTab(query: $query, addedFoods: $addedFoods)
            case 1:
                SavedMealsTab(addedFoods: $addedFoods, persistenceController: persistenceController)
            default:
                Text("Default")
            }
            Spacer()
        }
    }
}

struct AddMealTabBar_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView(obDays: ObservableDays(), persistenceController: PersistenceController(), obMeals: ObservableMeals())
    }
}
