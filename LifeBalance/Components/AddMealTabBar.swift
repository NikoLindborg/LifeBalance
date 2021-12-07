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
    var body: some View {
        
        VStack {
            Picker("", selection: $selectedTab) {
                Text("Add new").tag(0)
                Text("My foods").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            switch(selectedTab) {
            case 0:
                SearchView(addedFoods: $addedFoods)
            case 1:
                Text("My foods")
            default:
                Text("hai")
            }
            Spacer()
        }
    }
}

