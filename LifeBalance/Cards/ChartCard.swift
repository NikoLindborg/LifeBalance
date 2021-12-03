//
//  ChartCard.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 3.12.2021.
//

import SwiftUI
import HealthKit

struct ChartCard: View {
    
    @State var pickerSelection = 1
    @State var dataPoints: [[CGFloat]] = [[50,100,140,13,75,125,180],
                                          [20,150,120,153,121,51,52]]
    @Binding var realData: [[CGFloat]]
    @Binding var isLoaded: Bool
    @Binding var max: Double
    
    var body: some View {
        if (isLoaded) {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.green)
                VStack {
                    Text("Goals")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                    Picker(selection: $pickerSelection, label: Text("")) {
                        Text("Week").tag(1)
                        Text("Month").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 20)
             
                        HStack(spacing: 16) {
                            BarView(value: realData[pickerSelection][0], max: Float(max))
                            BarView(value: realData[pickerSelection][1], max: Float(max))
                            BarView(value: realData[pickerSelection][2], max: Float(max))
                            BarView(value: realData[pickerSelection][3], max: Float(max))
                            BarView(value: realData[pickerSelection][4], max: Float(max))
                            BarView(value: realData[pickerSelection][5], max: Float(max))
                            BarView(value: realData[pickerSelection][6], max: Float(max))
                        }
                        .animation(.default)
                }
            }
            .frame(width: 350, height: 350, alignment: .leading)
        }
    }
}

struct BarView: View {
    
    var value: CGFloat
    var max: Float
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule().frame(width: 25, height: 200)
                    .foregroundColor(Color.gray)
                let percent = value / CGFloat(max)
                Capsule().frame(width: 30, height: (percent * 200))
                    .foregroundColor(Color.orange)
            }
            Text("D")
        }
    }
}
