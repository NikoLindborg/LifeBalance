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
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Day.date, ascending: true)],
//        animation: .default)
//    private var days: FetchedResults<Day>
    @State var themeColor: ColorScheme

    var body: some View {
        TabView {
            HomeView()
                .tabItem() {
                    Image(systemName: "heart.fill")
                    Text("Home")
                }
            DiaryView()
                .tabItem() {
                    Image(systemName: "book.fill")
                    Text("Diary")
                }
            AddMealView()
                .tabItem() {
                    Image(systemName: "plus.circle.fill")
                    Text("Add meal")
                }
            SettingsView(persistenceController: PersistenceController(), themeColor: $themeColor)
                .tabItem() {
                    Image(systemName: "slider.vertical.3")
                    Text("Settings")
                }
        }
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
