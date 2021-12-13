//
//  ContentView.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 23.11.2021.
//

/**
 ContentView contains the initial UI for this application. It iis used to present custom content onscreen and to pass data between views.
 */

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) private var systemTheme
    let persistenceController = PersistenceController()
    @State var themeColor: ColorScheme
    @ObservedObject var tSettings = ObservableTrends()
    @ObservedObject var dailyProgressSettings = ObservableDailyProgress()
    @ObservedObject var observedActivity = ObservableActivity()
    @ObservedObject var observableProgress = ObservableProgressValues()
    @StateObject private var tabController = TabController()
    let obMeals = ObservableMeals()
    let obAllDays = ObservableDays()
    let observedUpdate = ObservableUpdate()
    
    var body: some View {
        TabView(selection: $tabController.activeTab) {
            HomeView(persistenceController: persistenceController, observableProgress: observableProgress, tSettings: tSettings, dailyProgressSettings: dailyProgressSettings, observedActivity: observedActivity)
                .tag(Tab.home)
                .tabItem() {
                    Image(systemName: "heart.fill")
                    Text("Home")
                }      
                .onAppear(perform: persistenceController.initializeTrends)
                .onAppear(perform: persistenceController.initializeDailyProgressCoreData)
                .onAppear(perform: {print("trendit \(tSettings.trends) \(tSettings.trends.isEmpty)")})
                .onAppear(perform: {if $tSettings.trends.isEmpty {tSettings.update(); print("ajoin")}})
                .onAppear(perform: {if $dailyProgressSettings.dailyProgress.isEmpty {dailyProgressSettings.update();
                    print("ContentView - dailyProgressSettings updated")
                }})
                .onAppear(perform: {observableProgress.update()})

            DiaryView(persistenceController: persistenceController, obMeals: obMeals,dailyProgressSettings: dailyProgressSettings, meals: obMeals.meals, obDays: obAllDays, isUpdated: observedUpdate)
                .tag(Tab.diary)
                .tabItem() {
                    Image(systemName: "book.fill")
                    Text("Diary")
                }
            AddMealView(obDays: obAllDays, observableProgress: observableProgress, persistenceController: persistenceController, obMeals: obMeals)
                .tag(Tab.addMeal)
                .tabItem() {
                    Image(systemName: "plus.circle.fill")
                    Text("Add meal")
                }
            SettingsView(persistenceController: persistenceController, themeColor: $themeColor)
                .tag(Tab.settings)
                .tabItem() {
                    Image(systemName: "slider.vertical.3")
                    Text("Settings")
                }
        }
        .accentColor(Color.LB_purple)
        .environmentObject(tabController)
        .onAppear(perform: {
            if(!PersistenceController().loadUserSettings().isEmpty){
                themeColor = PersistenceController().loadUserSettings()[0].theme ? .light : .dark
            } else {
                themeColor = systemTheme
            }
            
        })
        .environment(\.colorScheme, themeColor)
        .preferredColorScheme(themeColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(themeColor: .light).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
