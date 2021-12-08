//
//  AmountView.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 7.12.2021.
//

import SwiftUI

struct AmountView: View {
    var max: Double
    
    var body: some View {
        VStack {
            VStack {
                Text("\(max, specifier: "%.0f")")
                    .font(.subheadline)
                Spacer()
                Text("\(max / 2, specifier: "%.0f")")
                    .font(.subheadline)
                Spacer()
                Text("0")
                    .font(.subheadline)
            }
            .frame(width: 50, height: 225, alignment: .trailing)
            .foregroundColor(.white)
        }
    }
}
