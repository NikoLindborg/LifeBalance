//
//  AmountView.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 7.12.2021.
//

/**
 This component is used in ChartCard.swift and it is used in charts right side to determine weeks maxium value, "halfway value" and bottom value which is 0
 */

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
