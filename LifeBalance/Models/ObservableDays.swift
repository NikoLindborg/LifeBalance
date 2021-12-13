//
//  ObservableDays.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 8.12.2021.
//

/**
 Observable class made for Days, made so views properly react to "state" change. Also contains few hardcoded day insertions for demo purposes.
 */

import Foundation

class ObservableDays: ObservableObject {
    @Published var allDays: [Day]
    let persistenceController = PersistenceController()
    
    init(){
        persistenceController.addDay(date: itemFormatter.string(from: Date.from(2021, 12, 11) ?? Date()))
        persistenceController.addDay(date: itemFormatter.string(from: Date.from(2021, 12, 12) ?? Date()))
        persistenceController.addDay(date: itemFormatter.string(from: Date.from(2021, 12, 13) ?? Date()))
        persistenceController.addDay(date: itemFormatter.string(from: Date()))
        self.allDays = persistenceController.loadDayEntities().reversed()
        
    }
}
extension Date {
    static func from(_ year: Int, _ month: Int, _ day: Int) -> Date?
    {
        let gregorianCalendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(calendar: gregorianCalendar, year: year, month: month, day: day)
        return gregorianCalendar.date(from: dateComponents)
    }
}
