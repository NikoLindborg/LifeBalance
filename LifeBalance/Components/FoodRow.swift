//
//  FoodRow.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 28.11.2021.
//

/**
 This component is used in AddNewTab.swift to show added food-item in list.
 */

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
    }
}

struct FoodRow_Previews: PreviewProvider {
    static var previews: some View {
        FoodRow(amount: 400)
    }
}
