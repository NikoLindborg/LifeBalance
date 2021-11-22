//
//  MealItems.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 21.11.2021.
//

import SwiftUI

struct MealItems: View {
    let food: String
    let amount: String
    var body: some View {
        HStack {
            Text("   •  \(self.food)")
                .foregroundColor(.white)
            Spacer()
            Text("\(self.amount)")
        }
    }
}

struct MealItems_Previews: PreviewProvider {
    static var previews: some View {
        MealItems(food: "Oatmeal", amount: "400g")
    }
}
