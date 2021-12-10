//
//  FoodRow.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 28.11.2021.
//

import SwiftUI

struct FoodRow: View {
    var food = ""
    var amount: Int
    var body: some View {
        HStack{
            Text(food)
            Spacer()
            Text("\(String(amount)) g")
        }
        .background(Color.LB_whiteSystemGray)
    }
}

struct FoodRow_Previews: PreviewProvider {
    static var previews: some View {
        FoodRow(amount: 400)
    }
}
