//
//  NutritionalDatalistView.swift
//  LifeBalance
//
//  Created by Jaani Kaukonen on 21.11.2021.
//
/*
 A bar view built to show more specific values of all the data the application can provide
 */

import SwiftUI

struct NutritionalDatalistView: View {
    @Binding var progressItems: [ProgressItem]
    
    
    var body: some View {
        VStack {
            List {
                ForEach(progressItems){ item in
                    NutritionDatalistItem(nutritionName: item.description, dailyConsumptionProgress: Double(item.consumed), dailyConsumptionTarget: Double(item.target), unit: item.unit)
                }
            }
            .listStyle(.inset)
            .navigationTitle("Nutrition details")
        }
    }
}
