//
//  ReferenceValues.swift
//  LifeBalance
//
//  Created by iosdev on 26.11.2021.
//

/**
 This file is used to calculate users daily micro and macro nutrient values based on intaked values
 Values are only indicative recommendations 
 */

import SwiftUI

class ReferenceValues: ObservableObject {
    
    @Published var calories: Double = 0
    //iron as mg
    @Published var iron: Double = 0
    //fat as g
    @Published var fat: Double = 0
    //carbs as g
    @Published var carbohydrates: Double = 0
    //protein as g
    @Published var protein: Double = 0
    //fiber as g
    @Published var fiber: Double = 0
    //sugar as g
    @Published var sugar: Double = 0
    //sodium as g
    @Published var sodium: Double = 0
    
    func getReferenceValues(height: String, weight: String, age: String, gender: String, activity: String, target: String) {
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
            
            if(userAge > 13 && userAge < 19) {
                iron = 11
                fiber = 28
            }
            if(userAge > 18) {
                iron = 8
                fiber = 34
            }
            sugar = 37.5
        }
        
        if(gender == "Female"){
             bmr = ((9.99 * userWeight) + (6.25 * userHeight) - (4.92 * userAge)) - 161
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
            
            if(userAge > 13 && userAge < 19) {
                iron = 15
            }
            if(userAge > 18 && userAge < 51) {
                iron = 18
            }
            if(userAge > 50) {
                iron = 8
            }

            fiber = 28
        
            sugar = 25
        }
        
        if(gender == "Undefined") {
            calories = 0
        }
        
        if(target == "Muscle gain") {
            calories += 500
        }
        if(target == "Weight loss") {
            calories -= 500
        }
        
        fat = ((calories * 0.30) / 9)
        carbohydrates = ((calories * 0.50) / 4)
        protein = ((calories * 0.20) / 4)
        sodium = 1.5
        
    }
}
