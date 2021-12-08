//
//  NutritionalDatalistView.swift
//  LifeBalance
//
//  Created by Jaani Kaukonen on 21.11.2021.
//

import SwiftUI

struct NutritionalDatalistView: View {
    @Binding var progressItems: [ProgressItem]
    
    
    var body: some View {
        VStack {
            List {
                ForEach(progressItems){ item in
                    NutritionDatalistItem(nutritionName: item.description, dailyConsumptionProgress: Double(item.consumed), dailyConsumptionTarget: Double(item.target), unit: item.unit)
                }
               /** NutritionDatalistItem(nutritionName: "Calories", dailyConsumptionProgress: 10.0, dailyConsumptionTarget: 50.0, unit: "g")
                NutritionDatalistItem(nutritionName: "Magnesium", dailyConsumptionProgress: 100, dailyConsumptionTarget: 400, unit: "mg")
                NutritionDatalistItem(nutritionName: "Vitamin B1", dailyConsumptionProgress: 0.5, dailyConsumptionTarget: 1.2, unit: "mg")
                NutritionDatalistItem(nutritionName: "Protein", dailyConsumptionProgress: 200, dailyConsumptionTarget: 200, unit: "g")
                NutritionDatalistItem(nutritionName: "Iron", dailyConsumptionProgress: 10.0, dailyConsumptionTarget: 50.0, unit: "g")
                NutritionDatalistItem(nutritionName: "Magnesium", dailyConsumptionProgress: 100, dailyConsumptionTarget: 400, unit: "mg")
                NutritionDatalistItem(nutritionName: "Vitamin B1", dailyConsumptionProgress: 0.5, dailyConsumptionTarget: 1.2, unit: "mg")
                NutritionDatalistItem(nutritionName: "Protein", dailyConsumptionProgress: 200, dailyConsumptionTarget: 200, unit: "g")*/
            }
            .listStyle(.inset)
            .navigationTitle("Nutrition details")
        }
    }
}
/**
struct NutritionalDatalistView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionalDatalistView(meals: ObservableMeals().meals)
    }
}
*/
