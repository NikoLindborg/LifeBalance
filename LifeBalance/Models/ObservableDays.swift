//
//  ObservableDays.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 8.12.2021.
//

import Foundation

class ObservableDays: ObservableObject {
    @Published var allDays: [Day]
    let persistenceController = PersistenceController()
    
    init(){
        persistenceController.addDay(date: itemFormatter.string(from: Date.from(2021, 12, 05) ?? Date()))
        persistenceController.addDay(date: itemFormatter.string(from: Date.from(2021, 12, 06) ?? Date()))
        persistenceController.addDay(date: itemFormatter.string(from: Date.from(2021, 12, 07) ?? Date()))
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
