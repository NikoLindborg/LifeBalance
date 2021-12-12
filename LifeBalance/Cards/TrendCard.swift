//
//  TrendCard.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 19.11.2021.
//


import SwiftUI

struct TrendCard: View {
    @State var cardCaption: String
    @State var cardValue:Float = 0.0
    @State var cardTarget: Float = 0.0
    @ObservedObject var observableProgress: ObservableProgressValues
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.LB_background)
            HStack {
                if(cardCaption != "No trends"){
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
                        if(cardCaption != "No trends"){
                            if(cardValue < cardTarget/2){
                                Text("your \(self.cardCaption.lowercased()) levels are not doing well, make sure to eat food that has a lot of \(self.cardCaption.lowercased())")
                                Spacer()
                            } else if (cardValue >= cardTarget/2 && cardValue < cardTarget){
                                Text("your \(self.cardCaption.lowercased()) levels are above 50% of the needed consumption for the last 3 days, so you're on the right track, keep up the good work!")
                                Spacer()
                            } else {
                                Text("your \(self.cardCaption.lowercased()) levels are doing really well for the last 3 days, you're above your target! Great job")
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
                .onAppear(perform: {
                    if(cardCaption == "Iron"){
                        cardValue = observableProgress.ironConsumed
                        cardTarget = observableProgress.ironTarget
                    }
                    if(cardCaption == "Calories"){
                        cardValue = observableProgress.caloriesConsumed
                        cardTarget = observableProgress.caloriesTarget
                    }
                    if(cardCaption == "Protein"){
                        cardValue = observableProgress.proteinConsumed
                        cardTarget = observableProgress.proteinTarget
                    }
                    if(cardCaption == "Carbs"){
                        cardValue = observableProgress.carbsConsumed
                        cardTarget = observableProgress.carbsTarget
                    }
                    if(cardCaption == "Sugar"){
                        cardValue = observableProgress.sugarConsumed
                        cardTarget = observableProgress.sugarTarget
                    }
                    if(cardCaption == "Salt"){
                        cardValue = observableProgress.saltConsumed
                        cardTarget = observableProgress.saltTarget
                    }
                    
                })
                .padding([.trailing, .leading])
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 125, maxHeight: 125)
        }
    }
    }
