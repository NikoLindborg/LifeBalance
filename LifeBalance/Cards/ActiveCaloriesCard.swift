//
//  ActiveCaloriesCard.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 26.11.2021.
//

import SwiftUI
import HealthKit

struct ActiveCaloriesCard: View {
    @State var dataArray: Array<DataArrayItem> = []
    @State var max: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.yellow)
            VStack {
                HStack {
                    Text("Active calories last week")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                }
                HStack {
                    ForEach(dataArray) {item in
                        ProgressView(value: item.data / self.max)
                    }
                    .accentColor(.red)
                }
                Spacer()
            }
            .padding(10)
        }
        .frame(width: 350, height: 175, alignment: .leading)
    }
}

