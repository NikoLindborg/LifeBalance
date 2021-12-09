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
                .padding(.horizontal, 20)
                
                if (isLoaded) {
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
                    .animation(.default)
                }
            }
        }
        .frame(width: 350, height: 350, alignment: .leading)
        .onAppear(perform: {combineArrays(arrayOne: activityData, arrayTwo: stepData)})
    }
    func combineArrays(arrayOne: [[CGFloat]], arrayTwo: [[CGFloat]]) {
        combinedArray.removeAll()
        self.combinedArray.append(arrayOne[0])
        self.combinedArray.append(arrayTwo[0])
        self.isLoaded = true
    }

}
