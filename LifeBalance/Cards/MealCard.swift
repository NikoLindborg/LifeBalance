//
//  MealCard.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 21.11.2021.
//
/*
 Meal Card takes and array called food as parameter and displays it's items on the card.
 The items are Ingredient objects that the given meal has in the applications Core Data.
 */

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
                    // Displays the ingredients that are in realtionship with given meal. 
                    ForEach(food) {ingredient in
                        MealItems(food: ingredient.label ?? "", amount: String(ingredient.quantity))
                    }
                }
            }
            .padding(20)
        }
        .padding([.trailing, .leading])
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 125, maxHeight: 500)
    }

}
