//
//  NutritionalDatalistView.swift
//  LifeBalance
//
//  Created by Jaani Kaukonen on 21.11.2021.
//

import SwiftUI

struct NutritionalDatalistView: View {
    var body: some View {
        VStack {
            Text("Nutrition details")
                .font(.title)
                .bold()
            List {
                NutritionDatalistItem(nutritionName: "Iron", dailyConsumptionProgress: 10.0, dailyConsumptionTarget: 50.0, unit: "g")
                NutritionDatalistItem(nutritionName: "Magnesium", dailyConsumptionProgress: 100, dailyConsumptionTarget: 400, unit: "mg")
                NutritionDatalistItem(nutritionName: "Vitamin B1", dailyConsumptionProgress: 0.5, dailyConsumptionTarget: 1.2, unit: "mg")
                NutritionDatalistItem(nutritionName: "Protein", dailyConsumptionProgress: 200, dailyConsumptionTarget: 200, unit: "g")
            }
            .listStyle(.inset)
        }
    }
}

struct NutritionalDatalistView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionalDatalistView()
    }
}
