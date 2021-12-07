//
//  ChartCard.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 3.12.2021.
//

import SwiftUI
import HealthKit

struct ChartCard: View {
    
    @State var pickerSelection = 0
    @State var activityData: [[CGFloat]]
    @State var stepData: [[CGFloat]]
    @State var maxActivity: Double
    @State var maxSteps: Double
    @State var weekdays: Array<String>
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.green)
            VStack {
                Picker(selection: $pickerSelection.animation(.default), label: Text("")) {
                    Text("Active energy").tag(0)
                    Text("Step count").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)
                
                // Could be done in a ForEach but apparently it enables the animation based on documentation
                if (pickerSelection == 0) {
                    HStack(spacing: 16) {
                        BarView(value: activityData[0][0], max: Float(maxActivity), day: weekdays[0])
                        BarView(value: activityData[0][1], max: Float(maxActivity), day: weekdays[1])
                        BarView(value: activityData[0][2], max: Float(maxActivity), day: weekdays[2])
                        BarView(value: activityData[0][3], max: Float(maxActivity), day: weekdays[3])
                        BarView(value: activityData[0][4], max: Float(maxActivity), day: weekdays[4])
                        BarView(value: activityData[0][5], max: Float(maxActivity), day: weekdays[5])
                        BarView(value: activityData[0][6], max: Float(maxActivity), day: weekdays[6])
                        AmountView(max: maxActivity)
                    }
                    .animation(.default)
                } else {
                    HStack(spacing: 16) {
                        BarView(value: stepData[0][0], max: Float(maxSteps), day: weekdays[0])
                        BarView(value: stepData[0][1], max: Float(maxSteps), day: weekdays[1])
                        BarView(value: stepData[0][2], max: Float(maxSteps), day: weekdays[2])
                        BarView(value: stepData[0][3], max: Float(maxSteps), day: weekdays[3])
                        BarView(value: stepData[0][4], max: Float(maxSteps), day: weekdays[4])
                        BarView(value: stepData[0][5], max: Float(maxSteps), day: weekdays[5])
                        BarView(value: stepData[0][6], max: Float(maxSteps), day: weekdays[6])
                        AmountView(max: maxSteps)
                    }
                    .animation(.default)
                }
            }
        }
        .frame(width: 350, height: 350, alignment: .leading)
    }
}
