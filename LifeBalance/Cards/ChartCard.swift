//
//  ChartCard.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 3.12.2021.
//
/*
 ChartCard displays a chart on the HomeView that is built from Apple's HealthKit data that the user has in Apple Health.
 
 The application fetches step and active energy data from HealthKit and displays them in a BarView that is built for this chart.
 */

import SwiftUI
import HealthKit

struct ChartCard: View {
    @State var pickerSelection = 0
    @Binding var activityData: [[CGFloat]]
    @Binding var stepData: [[CGFloat]]
    @Binding var maxActivity: Double
    @Binding var maxSteps: Double
    @Binding var weekdays: Array<String>
    @Binding var healthData: Bool
    @State var combinedArray: [[CGFloat]] = []
    @State var isLoaded: Bool = false
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.LB_dataBackground)
            VStack {
                Picker(selection: $pickerSelection, label: Text("")) {
                    Text("Active energy").tag(0)
                    Text("Step count").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // This could have been done in a loop to reduce lines of code, but it broke the Animation of the graph
                // This way the pickerselection sets which data is read from the combined array as well as wether it compares it to the maximum activity or steps.
                // Arrays are combined when this Card is loaded. 
                if (isLoaded && healthData) {
                    HStack(spacing: 13) {
                        BarView(value: combinedArray[pickerSelection][0], max: pickerSelection == 0 ? Float(maxActivity) : Float(maxSteps), day: weekdays[0])
                        BarView(value: combinedArray[pickerSelection][1], max: pickerSelection == 0 ? Float(maxActivity) : Float(maxSteps), day: weekdays[1])
                        BarView(value: combinedArray[pickerSelection][2], max: pickerSelection == 0 ? Float(maxActivity) : Float(maxSteps), day: weekdays[2])
                        BarView(value: combinedArray[pickerSelection][3], max: pickerSelection == 0 ? Float(maxActivity) : Float(maxSteps), day: weekdays[3])
                        BarView(value: combinedArray[pickerSelection][4], max: pickerSelection == 0 ? Float(maxActivity) : Float(maxSteps), day: weekdays[4])
                        BarView(value: combinedArray[pickerSelection][5], max: pickerSelection == 0 ? Float(maxActivity) : Float(maxSteps), day: weekdays[5])
                        BarView(value: combinedArray[pickerSelection][6], max: pickerSelection == 0 ? Float(maxActivity) : Float(maxSteps), day: weekdays[6])
                        AmountView(max: pickerSelection == 0 ? maxActivity : maxSteps)
                    }
                }
            }
        }
        .padding([.trailing, .leading])
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 350, maxHeight: 350)
        .onAppear(perform: {combineArrays(arrayOne: activityData, arrayTwo: stepData)})
    }
    func combineArrays(arrayOne: [[CGFloat]], arrayTwo: [[CGFloat]]) {
        combinedArray.removeAll()
        self.combinedArray.append(arrayOne[0])
        self.combinedArray.append(arrayTwo[0])
        self.isLoaded = true
    }

}
