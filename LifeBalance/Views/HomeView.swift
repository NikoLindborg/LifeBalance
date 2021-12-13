//
//  HomeView.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 15.11.2021.
//
/*
 HomeView displays various data to the user, such as Daily Progress, Trends and Activity.
 
 Some of the data is passed to other views as binding values for other views to display them.
 */

import SwiftUI

struct HomeView: View {
    @State var color = Color.green
    @EnvironmentObject var healthKit: HealthKit
    let persistenceController: PersistenceController
    @EnvironmentObject private var tabController: TabController
    let dayBeforeYesterday = itemFormatter.string(from: Calendar.current.date(byAdding: .day, value: -2, to: Date())!)
    let yesterday = itemFormatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
    let today = itemFormatter.string(from: Date())
    @ObservedObject var observableProgress: ObservableProgressValues
    @ObservedObject var tSettings: ObservableTrends
    @State var realData: [[CGFloat]] = [[]]
    @State var isLoaded = false
    @ObservedObject var dailyProgressSettings: ObservableDailyProgress
    @ObservedObject var observedActivity: ObservableActivity
    @State var showAlert = !UserDefaults.standard.bool(forKey: "FirstStart")
    
    var body: some View {
        NavigationView {
            ScrollView {
                // Alert for when the app is first launched to inform the user to enter hers/his information.
                Text("")
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Hello LifeBalancer"),
                              message: Text("In order to use the nutrient tracking properly, please enter your details in Settings"),
                              dismissButton: Alert.Button.default(
                                Text("Ok"), action: {
                                    UserDefaults.standard.set(true, forKey: "FirstStart")
                                }
                              )
                        )
                    })
                VStack {
                    HStack {
                        Text("Today")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        if(!$dailyProgressSettings.dailyProgress.isEmpty){
                            NavigationLink(destination: DailyProgressView(dailyProgressSettings: $dailyProgressSettings.dailyProgress[0], persistenceController: persistenceController, observedDailyProgress: dailyProgressSettings)){
                                Text("Edit")
                                    .bold()
                                    .padding(.trailing)
                            }
                        }
                    }
                    .padding(.leading)
                    NavigationLink(destination: NutritionalDatalistView(progressItems: $observableProgress.fullProgressValues), label: {
                        VStack(alignment: .leading){
                            DailyProgressCard(progressValues: $dailyProgressSettings.progressValues, color: $color, color2: $color, color3: $color, color4: $color)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: 350)
                                .background(Color.LB_purple)
                                .cornerRadius(20)
                        }
                        .padding([.trailing, .leading])
                    })
                    Button(action: {
                        tabController.open(.addMeal)
                    }) {
                        Text("Add new meal")
                            .font(.largeTitle)
                            .bold()
                            .padding(.leading)
                        Spacer()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                    .background(Color.LB_green)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding([.trailing, .leading])
                }
                .offset(y: -20)
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
                                    .padding(.trailing)
                            }
                        }
                    }
                    .padding()
                    // Logic for showing the selected trends
                    if(tSettings.trends.count != 0){
                        if(!tSettings.trends[0].trend_iron && !tSettings.trends[0].trend_calories && !tSettings.trends[0].trend_protein && !tSettings.trends[0].trend_carbs && !tSettings.trends[0].trend_sugar && !tSettings.trends[0].trend_salt){
                            TrendCard(cardCaption: "No trends", observableProgress: observableProgress)
                        } else {
                            if tSettings.trends[0].trend_iron {
                                TrendCard(cardCaption: "Iron", observableProgress: observableProgress)
                            }
                            if tSettings.trends[0].trend_calories {
                                TrendCard(cardCaption: "Calories", observableProgress: observableProgress)
                            }
                            if tSettings.trends[0].trend_protein {
                                TrendCard(cardCaption: "Protein", observableProgress: observableProgress)
                            }
                            if tSettings.trends[0].trend_carbs {
                                TrendCard(cardCaption: "Carbs", observableProgress: observableProgress)
                            }
                            if tSettings.trends[0].trend_sugar {
                                TrendCard(cardCaption: "Sugar", observableProgress: observableProgress)
                            }
                            if tSettings.trends[0].trend_salt {
                                TrendCard(cardCaption: "Salt", observableProgress: observableProgress)
                            }
                        }
                    }
                }
                .offset(y: -20)
                VStack {
                    HStack {
                        Text("Activity")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding()
                    if ($observedActivity.healthData.wrappedValue) {
                        VStack {
                            ChartCard(activityData: $observedActivity.healthKitActivityArray, stepData: $observedActivity.healthKitStepsArray, maxActivity: $observedActivity.healthKitMaxActivity, maxSteps: $observedActivity.healthKitMaxSteps, weekdays: $observedActivity.weekdays, healthData: $observedActivity.healthData)
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
                .offset(y: -20)
            }
        }
        // A lot of logic is handled when the HomeView is launched, as it is the first View that the application launches.
        // The application authorized HealthData in the homeview as well as creates reference values if they don't already exists.
        // A day entity is also created to CoreData if it doesn't already exist so if the day has changed, last days values are not displayed.
        // The correct settings and saved meal items are fetched from CoreData, and the needed observable object are updated
        .onAppear(perform: healthKit.authorizeHealthStore)
        .onAppear(perform: persistenceController.createRefValuesEntity)
        .onAppear(perform: {persistenceController.addDay(date: today)})
        .onAppear(perform: persistenceController.initializeDailyProgressCoreData)
        .onAppear(perform: dailyProgressSettings.update)
        .onAppear(perform: dailyProgressSettings.fetchList)
        .onAppear(perform: {observableProgress.update()})
        
        // Here the applications background is set to clear instead of systemGray6 to provide a white background.
        .onAppear(perform: {UITableView.appearance().backgroundColor = .clear})
        // If HealthData is authorized, the fetched values are passed to the Observavle observedActivity object.
        .onChange(of: healthKit.healthData, perform: {(value) in
            observedActivity.update(activityData: healthKit.activityData, stepData: healthKit.stepData, maxActivity: healthKit.maxActivity, maxSteps: healthKit.maxSteps, weekdays: healthKit.weekdays, healthData: healthKit.healthData)
        })
    }
}
