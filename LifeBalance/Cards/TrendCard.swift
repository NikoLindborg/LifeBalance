//
//  TrendCard.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 19.11.2021.
//


import SwiftUI

struct TrendCard: View {
    @State var cardCaption: String
    @State var cardText: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.LB_background)
            VStack {
                HStack {
                    Text(self.cardCaption)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                HStack {
                    Text(self.cardText)
                    Spacer()
                }
            }
            .padding(10)
        }
        .padding([.trailing, .leading])
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 125, maxHeight: 125)
    }
    
}
