//
//  ObservableTrends.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 6.12.2021.
//

import Foundation

class ObservableTrends: ObservableObject {
    @Published var trends: [TrendSettings] = []
    let persistenceController = PersistenceController()
    
    func update(){
        self.trends = persistenceController.getTrendSettings()
    }
    
}
