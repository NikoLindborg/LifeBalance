//
//  ContentView.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 23.11.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) private var systemTheme
    let persistenceController = PersistenceController()
    @State var themeColor: ColorScheme
    @StateObject private var tabController = TabController()
    let obMeals = ObservableMeals()
    
    var body: some View {
        TabView(selection: $tabController.activeTab) {
            HomeView(persistenceController: persistenceController)
                .tag(Tab.home)
                .tabItem() {
                    Image(systemName: "heart.fill")
                    Text("Home")
                }
            DiaryView(persistenceController: persistenceController, obMeals: obMeals)
                .tag(Tab.diary)
                .tabItem() {
                    Image(systemName: "book.fill")
                    Text("Diary")
                }
            AddMealView(persistenceController: persistenceController, obMeals: obMeals)
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
