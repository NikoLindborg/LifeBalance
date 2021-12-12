//
//  TrendCard.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 19.11.2021.
//


import SwiftUI

struct TrendCard: View {
    @State var cardCaption: String
    @State var cardTrend: String
    @State var cardValue: Float
    @State var cardTarget: Float
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.LB_background)
            HStack {
                if(cardTrend != "nothing"){
                if(cardValue < cardTarget/2){
                    Image(systemName: "chevron.down.circle").foregroundColor(.red)
                } else if (cardValue >= cardTarget/2 && cardValue < cardTarget){
                    Image(systemName: "chevron.right.circle").foregroundColor(.yellow)
                } else {
                    Image(systemName: "chevron.up.circle").foregroundColor(.green)
                }
                }
                VStack {
                    HStack {
                        Text(self.cardCaption)
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        if(cardTrend != "nothing"){
                        if(cardValue < cardTarget/2){
                        Text("your \(self.cardTrend) levels are not doing well, make sure to eat food that has a lot of \(self.cardTrend)")
                        Spacer()
                        } else if (cardValue >= cardTarget/2 && cardValue < cardTarget){
                            Text("your \(self.cardTrend) levels are above 50% of the needed consumption for the last 3 days, so you're on the right track, keep up the good work!")
                            Spacer()
                        } else {
                            Text("your \(self.cardTrend) levels are doing really well for the last 3 days, you're above your target! Great job")
                            Spacer()
                        }
                        }else {
                            Text("Add trend cards from edit")
                            Spacer()
                        }
                    }
                }
                .padding(10)
            }.padding(10)
            
        }
        .padding([.trailing, .leading])
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 125, maxHeight: 125)
    }
    
}
