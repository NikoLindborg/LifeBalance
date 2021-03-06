//
//  DailyProgressCard.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 21.11.2021.
//
/*
 Daily Progress card shows the passed progress settings and values as a observed object parameter.
 
 This data includes the users selected nutrients she/he wants to be shown on the Daily Progress as well as the consumed and reference values for that specific nutrient. 
 */

import SwiftUI

struct DailyProgressCard: View {
    @Binding var progressValues: Array<ProgressItem>
    @Binding var color: Color
    @Binding var color2: Color
    @Binding var color3: Color
    @Binding var color4: Color
    
    var body: some View {
        VStack(){
            if(!progressValues.isEmpty){
                if(progressValues.count > 2){
                    HStack(){
                        Text("Daily progress")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                            .frame(width: 300, height: 40, alignment: .topLeading)
                    }.offset(x: -10, y: 10)
                } else {
                    HStack(){
                        Text("Daily progress")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                            .frame(width: 300, height: 20, alignment: .topLeading)
                    }.offset(x: -10, y: -40)
                }
                
                HStack(){
                    //  Logic for displaying ProgressBars in a different manner on the card based on their amount. If amount is bigger than 2, the size is reduced and ProgressBars are seperated for two rows.
                    if(progressValues.count > 2){
                            LazyHGrid(rows: [GridItem(.flexible()),GridItem(.flexible())], alignment: .center, spacing: 80){
                                ForEach($progressValues) {item in
                                    VStack{
                                        ProgressBar(progress: item.progress, color: self.$color2)
                                            .frame(width: 50.0, height: 50.0)
                                        Text("\(item.consumed.wrappedValue, specifier: "%.0f") / \(item.target.wrappedValue, specifier: "%.0f") \(item.unit.wrappedValue)")
                                            .foregroundColor(Color.white)
                                        Text(item.description.wrappedValue)
                                            .foregroundColor(Color.white)
                                    }
                                }
                            }.frame(height: 300)
                    }
                    else {
                        LazyHGrid(rows: [GridItem(.fixed(2))], alignment: .center){
                            ForEach($progressValues) {item in
                                VStack{
                                    ProgressBar(progress: item.progress, color: self.$color2)
                                        .frame(width: 100.0, height: 100.0)
                                        .padding(20)
                                    Text("\(item.consumed.wrappedValue, specifier: "%.0f") / \(item.target.wrappedValue, specifier: "%.0f") \(item.unit.wrappedValue)")
                                        .foregroundColor(Color.white)
                                    Text(item.description.wrappedValue)
                                        .foregroundColor(Color.white)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
