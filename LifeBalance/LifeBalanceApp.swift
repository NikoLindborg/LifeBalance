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
    var healthKit = HealthKit()
    @Environment(\.colorScheme) private var systemTheme
    
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView(themeColor: !PersistenceController().loadUserSettings().isEmpty ? PersistenceController().loadUserSettings()[0].theme ? .light : .dark : systemTheme
            )
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(parser)
                .environmentObject(nutrientsParser)
                .environmentObject(healthKit)   
        
        }
    }
}
