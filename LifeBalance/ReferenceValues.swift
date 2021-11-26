//
//  ReferenceValues.swift
//  LifeBalance
//
//  Created by iosdev on 26.11.2021.
//

import SwiftUI

class ReferenceValues: ObservableObject {
    
    @Published var calories: Double = 0
    @Published var iron: Double = 0
    
    func getReferenceValues(height: String, weight: String, age: String, gender: String, activity: String) {
        let userHeight = Double(height) ?? 0
        let userWeight = Double(weight) ?? 0
        let userAge = Double(age) ?? 0
        var amr: Double = 0
        var bmr: Double = 0
        
        if(gender == "Male"){
             bmr = ((9.99 * userWeight) + (6.25 * userHeight) - (4.92 * userAge)) + 5
            if(activity == "Sedentary") {
                amr = (bmr * 1.2)
            }
            if(activity == "Lightly active") {
                amr = (bmr * 1.375)
            }
            if(activity == "Moderately active") {
                amr = (bmr * 1.55)
            }
            if(activity == "Active") {
                amr = (bmr * 1.725)
            }
            if(activity == "Very active") {
                amr = (bmr * 1.9)
            }
            calories = amr
            
            //iron as mg
            if(userAge > 13 && userAge < 19) {
                iron = 11
            }
            if(userAge > 18) {
                iron = 8
            }
        }
        
        if(gender == "Female"){
             bmr = ((9.99 * userWeight) + (6.25 * userHeight) - (4.92 * userAge)) - 161
            if(activity == "Sedentary") {
                amr = (bmr * 1.2)
                print(amr)
            }
            if(activity == "Lightly active") {
                amr = (bmr * 1.375)
                print(amr)
            }
            if(activity == "Moderately active") {
                amr = (bmr * 1.55)
                print(amr)
            }
            if(activity == "Active") {
                amr = (bmr * 1.725)
                print(amr)
            }
            if(activity == "Very active") {
                amr = (bmr * 1.9)
                print(amr)
            }
            calories = amr
            
            //iron as mg
            if(userAge > 13 && userAge < 19) {
                iron = 15
            }
            if(userAge > 18 && userAge < 51) {
                iron = 18
            }
            if(userAge > 50) {
                iron = 8
            }
        }
        
        if(gender == "Undefined") {
            calories = 0
        }
    }
}
