//
//  LifeBalanceApp.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 15.11.2021.
//

import SwiftUI

@main
struct LifeBalanceApp: App {
    var parser = FoodParser()
    var nutrientsParser = NutrientsParser()
    
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(parser)
                .environmentObject(nutrientsParser)
        }
    }
}
