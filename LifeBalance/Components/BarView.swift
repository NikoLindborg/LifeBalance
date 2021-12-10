//
//  BarView.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 7.12.2021.
//

import SwiftUI

struct BarView: View {
    var value: CGFloat
    var max: Float
    var day: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule().frame(width: 20, height: 200)
                    .foregroundColor(Color.gray)
                    .zIndex(1)
                let percent = value / CGFloat(max)
                Capsule().frame(width: 20, height: (percent * 200))
                    .foregroundColor(Color.LB_dataHighlight)
                    .zIndex(2)
            }
            .animation(.default)
            Text(day)
                .font(.subheadline)
        }
        .foregroundColor(.white)

    }
}
