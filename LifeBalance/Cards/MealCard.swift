//
//  MealCard.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 21.11.2021.
//

import SwiftUI

struct MealCard: View {
    let meal: String
    let food:Array<Ingredient>
    let backgroundColor: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(self.backgroundColor)
            VStack {
                HStack {
                    Text(self.meal)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Spacer()
                }
                VStack {
                    ForEach(food) {ingredient in
                        MealItems(food: ingredient.label ?? "", amount: String(ingredient.quantity))
                    }
                }
            }
            .padding(20)
        }
        .frame(width: 350, height: 125, alignment: .leading)
    }

}
