//
//  DailyProgressCard.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 21.11.2021.
//

import SwiftUI

struct DailyProgressCard: View {
    @Binding var progressValues: Array<ProgressItem>
    @Binding var color: Color
    @Binding var color2: Color
    @Binding var color3: Color
    @Binding var color4: Color
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
                HStack {
                    ForEach($progressValues) {item in
                        VStack{
                            ProgressBar(progress: item.progress, color: self.$color2)
                                .frame(width: 50.0, height: 50.0)
                                .padding(20)
                            Text("\(item.consumed.wrappedValue, specifier: "%.0f") / \(item.target.wrappedValue, specifier: "%.0f") \(item.unit.wrappedValue)")
                                .foregroundColor(Color.white)
                            Text(item.description.wrappedValue)
                                .foregroundColor(Color.white)
                        }
                    }
                    /*VStack {
                        ProgressBar(progress: self.$progressValue, color: self.$color)
                            .frame(width: 50.0, height: 50.0)
                            .padding(20)
                        Text("Protein 50 / 200")
                            .foregroundColor(Color.white)
                        Spacer()
                        ProgressBar(progress: self.$progressValue, color: self.$color2)
                            .frame(width: 50.0, height: 50.0)
                            .padding(20)
                        Text("Carbs 50 / 200")
                            .foregroundColor(Color.white)
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
                        .foregroundColor(Color.white)
                    Spacer()
                    ProgressBar(progress: self.$progressValue, color: self.$color4)
                        .frame(width: 50.0, height: 50.0)
                        .padding(20)
                    Text("Protein 50 / 200")
                        .foregroundColor(Color.white)
                    Spacer()*/
                }
                Spacer()
            }
        }
        .background(Color(red:0.45, green: 0.32, blue:0.59))
    }
}
