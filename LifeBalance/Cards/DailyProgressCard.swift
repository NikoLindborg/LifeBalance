//
//  DailyProgressCard.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 21.11.2021.
//

import SwiftUI

struct DailyProgressCard: View {
    @Binding var progressValue: Float
    @Binding var color: Color
    @Binding var color2: Color
    @Binding var color3: Color
    @Binding var color4: Color
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
                ZStack {
                    VStack {
                        ProgressBar(progress: self.$progressValue, color: self.$color)
                            .frame(width: 50.0, height: 50.0)
                            .padding(20)
                        Text("Protein 50 / 200")
                            .foregroundColor(Color.black)
                        Spacer()
                        ProgressBar(progress: self.$progressValue, color: self.$color2)
                            .frame(width: 50.0, height: 50.0)
                            .padding(20)
                        Text("Carbs 50 / 200")
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                }
                Spacer()
                Spacer()
                Spacer()
                VStack {
                    ProgressBar(progress: self.$progressValue, color: self.$color3)
                        .frame(width: 50.0, height: 50.0)
                        .padding(20)
                    Text("Fats 50 / 200")
                        .foregroundColor(Color.black)
                    Spacer()
                    ProgressBar(progress: self.$progressValue, color: self.$color4)
                        .frame(width: 50.0, height: 50.0)
                        .padding(20)
                    Text("Protein 50 / 200")
                        .foregroundColor(Color.black)
                    Spacer()
                }
                Spacer()
            }
        }
        .background(Color(red:0.45, green: 0.32, blue:0.59))
    }
}
