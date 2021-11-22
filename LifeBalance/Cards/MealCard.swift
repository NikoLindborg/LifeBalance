//
//  MealCard.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 21.11.2021.
//

import SwiftUI

struct MealCard: View {
    let meal: String
    let food:Array<String>
    let amount: Array<String>
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
                    MealItems(food: food[0], amount: amount[0])
                    MealItems(food: food[1], amount: amount[1])
                }
            }
            .padding(10)
        }
        .frame(width: 350, height: 125, alignment: .leading)
    }
}

struct MealCard_Previews: PreviewProvider {
    static var previews: some View {
        MealCard(meal: "Breakfast", food: ["Oatmeal", "cottage-cheese"], amount: ["400g", "200g"], backgroundColor: Color.gray)
    }
}
