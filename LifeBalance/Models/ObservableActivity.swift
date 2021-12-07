//
//  ObservableActivity.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 7.12.2021.
//

import Foundation

class ObservableActivity: ObservableObject {
    @Published var healthDataArray: Array<DataArrayItem> = []
    var healthKit = HealthKit()

    init(){
        self.healthDataArray = healthKit.dataArray
    }
    
    func update() {
        self.healthDataArray = healthKit.dataArray
    }
}
