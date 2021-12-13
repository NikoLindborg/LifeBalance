//
//  EditItems.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 9.12.2021.
//

/**
 This component is used in EditMealView, it takes food name and amount, and is used to display them in a view.
 */

import SwiftUI

struct EditItems: View {
    let food: String
    let amount: String
    var body: some View {
        HStack {
            Text("\(self.food)")
            Spacer()
            Text("\(self.amount)g")
        }
        .padding()
        .foregroundColor(Color.LB_text)

    }
}
