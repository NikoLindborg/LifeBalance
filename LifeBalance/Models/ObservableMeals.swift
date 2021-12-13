//
//  ObservableMeals.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 6.12.2021.
//

/**
 Observable class made for Meals, made so views properly react to "state" change
 */

import Foundation

class ObservableMeals: ObservableObject {
    @Published var meals: [Meals]
    let persistenceController = PersistenceController()
    
    init(){
        self.meals = persistenceController.loadMealEntities(persistenceController.getDay(dateToCheck: itemFormatter.string(from: Date())))
    }
    
    func update() {
        print("OBmeals update")
        self.meals = persistenceController.loadMealEntities(persistenceController.getDay(dateToCheck: itemFormatter.string(from: Date())))
    }
}
