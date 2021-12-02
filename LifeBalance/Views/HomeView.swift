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
                    }
                    .padding(.leading, 28)
                    TrendCard(cardCaption: "Iron", cardText: "Your iron levels are looking better than normal", color: Color.gray)
                    TrendCard(cardCaption: "D-vitamin", cardText: "You seem not to get enough vitamin D", color: Color.yellow)
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
        .onAppear(perform: {getProgressValue()})
    }
    
    func getProgressValue() {
        // A dummy list for future reference for controlling what is shown on Daily Progress View
        let userSetNutritionalValues = ["calories", "iron"]
        progressValues = persistenceController.getProgressValues(userSetNutritionalValues: userSetNutritionalValues)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(persistenceController: PersistenceController())
            .environmentObject(HealthKit())
    }
}
