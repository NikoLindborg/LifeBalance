//
//  GoalsCard.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 19.11.2021.
//

import SwiftUI
import HealthKit

struct GoalsCard: View {
    @State var cardCaption: String
    @State var cardText: String
    @State var activeCalories: String
    @State var color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(self.color)
            VStack {
                HStack {
                    Text(self.cardCaption)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                }
                HStack {
                    Text(self.cardText)
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Text(activeCalories)
                        .foregroundColor(.white)
                    Spacer()
                }
                
            }
            .padding(10)
        }
        .frame(width: 350, height: 125, alignment: .leading)
    }

}

