//
//  HomeView.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 15.11.2021.
//

import SwiftUI

struct HomeView: View {
    @State var progressValues: Array<ProgressItem> = []
    @State var color = Color.green
    @EnvironmentObject var healthKit: HealthKit
    let persistenceController: PersistenceController
    @EnvironmentObject private var tabController: TabController
    let today = itemFormatter.string(from: Date())
    @ObservedObject var tSettings: ObservableTrends
    @State var realData: [[CGFloat]] = [[]]
    @State var isLoaded = false
    @ObservedObject var dailyProgressSettings: ObservableDailyProgress
    
    var body: some View {
        NavigationView {
            ScrollView {
                // For some reason doesnt work inside those stacks below??
                if(!$dailyProgressSettings.dailyProgress.isEmpty){
                    NavigationLink(destination: DailyProgressView(dailyProgressSettings: $dailyProgressSettings.dailyProgress[0], persistenceController: persistenceController, observedDailyProgress: dailyProgressSettings)){
                        Text("Edit")
                            .bold()
                            .padding(.trailing, 28)
                    }
                }
                VStack {
                    HStack {
                        Text("Today")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding(.leading, 28)
                
                    NavigationLink(destination: NutritionalDatalistView(), label: {
                        VStack(alignment: .leading){
                            DailyProgressCard(progressValues: $dailyProgressSettings.progressValues, color: $color, color2: $color, color3: $color, color4: $color)
                                .frame(width: 350, height: 250, alignment: .leading)
                                .background(Color.purple)
                                .cornerRadius(20)
                        }
                    })
                    Button(action: {
                        tabController.open(.addMeal)
                        
                    }) {
                        Text("Add new meal")
                            .font(.largeTitle)
                            .bold()
                            .padding(.leading, 10)
                            .frame(width: 350, height: 100, alignment: .leading)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    
                }
                .offset(y: -60)
                VStack {
                    HStack {
                        Text("Trends")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        if(!$tSettings.trends.isEmpty){
                            NavigationLink(destination: TrendsView(tSettings: $tSettings.trends[0], persistenceController: persistenceController)){
                                Text("Edit")
                                    .bold()
                                    .padding(.trailing, 28)
                            }
                        }
                    }
                    .padding(.leading, 28)
                    if(tSettings.trends.count != 0){
                        if(!tSettings.trends[0].trend_iron && !tSettings.trends[0].trend_calories && !tSettings.trends[0].trend_protein && !tSettings.trends[0].trend_carbs && !tSettings.trends[0].trend_sugar && !tSettings.trends[0].trend_salt){
                            TrendCard(cardCaption: "No trends", cardText: "Go to edit and add trend cards to show here", color: Color.gray)
                        } else {
                            if tSettings.trends[0].trend_iron {
                                TrendCard(cardCaption: "Iron", cardText: 0 == 0 ? "Too low iron" : "Too much iron", color: Color.gray)
                            }
                            if tSettings.trends[0].trend_calories {
                                TrendCard(cardCaption: "Calories", cardText: "Your calories levels are looking better than normal", color: Color.gray)
                            }
                            if tSettings.trends[0].trend_protein {
                                TrendCard(cardCaption: "Protein", cardText: "Your protein levels are looking better than normal", color: Color.gray)
                            }
                            if tSettings.trends[0].trend_carbs {
                                TrendCard(cardCaption: "Carbs", cardText: "Your carbs levels are looking better than normal", color: Color.gray)
                            }
                            if tSettings.trends[0].trend_sugar {
                                TrendCard(cardCaption: "Sugar", cardText: "Your sugar levels are looking better than normal", color: Color.gray)
                            }
                            if tSettings.trends[0].trend_salt {
                                TrendCard(cardCaption: "Salt", cardText: "Your salt levels are looking better than normal", color: Color.gray)
                            }
                        }
                    }
                    
                }
                .offset(y: -60)
                VStack {
                    HStack {
                        Text("Goals")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding(.leading, 28)
                    if (healthKit.healthData) {
                        VStack {
                            ChartCard(activityData: healthKit.activityData, stepData: healthKit.stepData, maxActivity: healthKit.maxActivity, maxSteps: healthKit.maxSteps, weekdays: healthKit.weekdays)
                        }
                    } else {
                        HStack{
                            Spacer()
                            Text("No Health Data available")
                            Spacer()
                        }
                        
                        .frame(width: 350, height: 100, alignment: .leading)
                    }
                }
                .offset(y: -60)
            }
        }
        .onAppear(perform: healthKit.authorizeHealthStore)
        .onAppear(perform: persistenceController.createRefValuesEntity)
        .onAppear(perform: {persistenceController.addDay(date: today)})
        .onAppear(perform: dailyProgressSettings.update)
        .onAppear(perform: dailyProgressSettings.fetchList)
    }
}
/**
 struct HomeView_Previews: PreviewProvider {
 static var previews: some View {
 HomeView(persistenceController: PersistenceController())
 .environmentObject(HealthKit())
 }
 }
 */
