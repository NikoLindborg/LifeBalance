//
//  NutritionDatalistItem.swift
//  LifeBalance
//
//  Created by Jaani Kaukonen on 21.11.2021.

/**
 This component takes nutrition name, consumed amount, target consumption and unit as input and outputs a single nutrition datalist item with corresponding data.
 */

import SwiftUI

struct NutritionDatalistItem: View {
    let nutritionName: String
    let dailyConsumptionProgress: Double
    let dailyConsumptionTarget: Double
    let unit: String
    
    var body: some View {
        let progressPercentage = calculateProgress(prog: dailyConsumptionProgress, target: dailyConsumptionTarget)
        HStack {
            Text(nutritionName)
                .frame(width: 200, alignment: .leading)
            VStack {
                Text("\(String(format: "%.1f", dailyConsumptionProgress)) / \(String(format: "%.1f", dailyConsumptionTarget)) \(unit)")
                        .font(.system(size: 14, weight: .medium))
                ProgressView(value: progressPercentage)
            }
                
        }
        .progressViewStyle(CustomProgressViewStyle())
        .padding(5)
        
    }
    
    func calculateProgress(prog: Double, target: Double) -> Double {
        if(target == 0 || prog > target){
            return 1.0
        } else{
            return prog/target
        }
    }
}

struct CustomProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .background(Color.clear)
            .accentColor(.gray)
    }
}

struct NutritionDatalistItem_Previews: PreviewProvider {
    static var previews: some View {
        NutritionDatalistItem(nutritionName: "Iron", dailyConsumptionProgress: 10.0, dailyConsumptionTarget: 50.0, unit: "g")
    }
}
