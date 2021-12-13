//
//  MealItems.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 21.11.2021.
//

/**
 This component is for MealCard to display meal items food name and amount
 */

import SwiftUI

struct MealItems: View {
    let food: String
    let amount: String
    var body: some View {
        HStack {
            Text("   •  \(self.food)")
                .foregroundColor(.white)
            Spacer()
            Text("\(self.amount)g")
                .foregroundColor(.white)
        }
    }
}

struct MealItems_Previews: PreviewProvider {
    static var previews: some View {
        MealItems(food: "Oatmeal", amount: "400g")
    }
}
