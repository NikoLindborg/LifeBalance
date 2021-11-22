//
//  LifeBalanceApp.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 15.11.2021.
//

import SwiftUI

@main
struct LifeBalanceApp: App {
    var body: some Scene {
        WindowGroup {
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
                SettingsView()
                    .tabItem() {
                        Image(systemName: "slider.vertical.3")
                        Text("Settings")
                    }
            }
        }
    }
}
