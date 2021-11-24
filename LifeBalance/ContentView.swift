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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Day.date, ascending: true)],
        animation: .default)
    private var days: FetchedResults<Day>
    
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
            SettingsView(persistenceController: PersistenceController())
                .tabItem() {
                    Image(systemName: "slider.vertical.3")
                    Text("Settings")
                }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
