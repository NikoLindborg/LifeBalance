//
//  EditItems.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 9.12.2021.
//

import SwiftUI

struct EditItems: View {
    let food: String
    let amount: String
    var body: some View {
        HStack {
            Text("   •  \(self.food)")
                .foregroundColor(.black)
            Spacer()
            Text("\(self.amount)g")
                .foregroundColor(.black)
        }.padding()
    }
}
