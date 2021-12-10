//
//  PersistenceTests.swift
//  LifeBalanceTests
//
//  Created by Jaani Kaukonen on 9.12.2021.
//

@testable import LifeBalance
import XCTest

class PersistenceTests: XCTestCase {
    var persistence: PersistenceController!
    
    override func setUp() {
        super.setUp()
        persistence = PersistenceController(inMemory: true)
    }
    
    override func tearDown() {
        persistence = nil
        super.tearDown()
    }
    
    func test_save_user_settings() throws {
        persistence.saveUserSettings(gender: "Male", height: "180", weight: "90", theme: false, activityLevel: "Active", target: "Weigth loss", age: "25")
        
        let userSettings = persistence.loadUserSettings()
        
        XCTAssertEqual(userSettings[0].gender, "Male")
        XCTAssertEqual(userSettings[0].height, "180")
        XCTAssertEqual(userSettings[0].weight, "90")
        XCTAssertEqual(userSettings[0].theme, false)
        XCTAssertEqual(userSettings[0].activityLevel, "Active")
        XCTAssertEqual(userSettings[0].target, "Weigth loss")
        XCTAssertEqual(userSettings[0].age, "25")
    }
    
    func test_update_user_settings() throws {
        persistence.saveUserSettings(gender: "Male", height: "180", weight: "90", theme: false, activityLevel: "Active", target: "Weigth loss", age: "25")
        
        var userSettings = persistence.loadUserSettings()
        
        persistence.updateUserSettings(userSettings: userSettings, gender: "Female", height: "160", weight: "70", target: "Weigth loss", activitylevel: "Very active", age: "28", theme: true)
        
        userSettings = persistence.loadUserSettings()
        
        XCTAssertEqual(userSettings[0].gender, "Female")
        XCTAssertEqual(userSettings[0].height, "160")
        XCTAssertEqual(userSettings[0].weight, "70")
        XCTAssertEqual(userSettings[0].theme, true)
        XCTAssertEqual(userSettings[0].activityLevel, "Very active")
        XCTAssertEqual(userSettings[0].target, "Weigth loss")
        XCTAssertEqual(userSettings[0].age, "28")
    }
    
    func test_check_if_available() throws {
        // If no dates are added and date is nil, checkIfAvailable should return true.
        XCTAssertTrue(persistence.checkIfAvailable(argument: "01.01.2021", nil))
        
        // When date is added and the date is nill, it should return false.
        persistence.addDay(date: "01.01.2021")
        XCTAssertFalse(persistence.checkIfAvailable(argument: "01.01.2021", nil))
        
        // When date is added, it should not contain any meals
        let days = persistence.loadDayEntities()
        XCTAssertTrue(persistence.checkIfAvailable(argument: "Breakfast", days[0]))
    }
}
