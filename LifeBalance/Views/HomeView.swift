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
//  @State private var tSettings: [TrendSettings] = [TrendSettings]()

        
    var body: some View {
        NavigationView {
            ScrollView {
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
                            DailyProgressCard(progressValues: $progressValues, color: $color, color2: $color, color3: $color, color4: $color)
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
                        NavigationLink(destination: TrendsView()){
                            Text("Edit")
                                .bold()
                                .padding(.trailing, 28)
                        }
                    }
                    .padding(.leading, 28)
                    if(true){
                        TrendCard(cardCaption: "No trend cards", cardText: "Go to edit to add what to see here", color: Color.gray)

                    }
//                    if tSettings[0].iron {
//                        TrendCard(cardCaption: "Iron", cardText: 0 == 0 ? "Too low iron" : "Too much iron", color: Color.gray)
//                    }
//                    if tSettings[0].calories {
//                        TrendCard(cardCaption: "calories", cardText: "Your calories levels are looking better than normal", color: Color.gray)
//                    }
//                    if tSettings[0].protein {
//                        TrendCard(cardCaption: "protein", cardText: "Your protein levels are looking better than normal", color: Color.gray)
//                    }
//                    if tSettings[0].carbs {
//                        TrendCard(cardCaption: "carbs", cardText: "Your carbs levels are looking better than normal", color: Color.gray)
//                    }
//                    if tSettings[0].sugar {
//                        TrendCard(cardCaption: "sugar", cardText: "Your sugar levels are looking better than normal", color: Color.gray)
//                    }
//                    if tSettings[0].salt {
//                        TrendCard(cardCaption: "salt", cardText: "Your salt levels are looking better than normal", color: Color.gray)
//                    }
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
                        GoalsCard(cardCaption: "Weight", cardText: "Your weight was -0.5kg compared to last week", activeCalories: "Your last workout burned \(healthKit.burntCalories) calories", color: Color.green)
                        ActiveCaloriesCard(dataArray: healthKit.dataArray, max: healthKit.max)
                    } else {
                        ActiveCaloriesCard(dataArray: healthKit.dataArray, max: healthKit.max)
                    }
                }
                .offset(y: -60)
            }
        }
        .onAppear(perform: healthKit.authorizeHealthStore)
        .onAppear(perform: persistenceController.createRefValuesEntity)
        .onAppear(perform: {persistenceController.addDay(date: today)})
        .onAppear(perform: getProgressValueToday)
//      .onAppear(perform: {tSettings = persistenceController.loadTrendSettings()})
    }
    
    func getProgressValueToday() {
        // anotherDate can be used to scope around different days by variating the "value: _"
        // Insert anotherDateString to getProgressValues parameter instead of today to switch day
        // let anotherDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        // let anotherDateString = itemFormatter.string(from: anotherDate)
        
        // A dummy list for future reference for controlling what is shown on Daily Progress View
        let userSetNutritionalValues = ["calories", "iron"]
        progressValues = persistenceController.getProgressValues(userSetNutritionalValues: userSetNutritionalValues, date: today)
        print(progressValues)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(persistenceController: PersistenceController())
            .environmentObject(HealthKit())
    }
}
