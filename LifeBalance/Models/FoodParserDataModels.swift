//
//  ParsedModel.swift
//  LifeBalance
//
//
//
//  Created by Niko Lindborg on 22.11.2021.
//

/**
 Datamodels for FoodParser api calls, has multiple structs that are only used in the same api calls datamodels
 */

import Foundation

struct ParsedModel: Decodable {
    var hints: [Hints]
}

struct Hints: Decodable, Identifiable, Hashable {
    var id: String{food.foodId}
    var food: Food
    
    init(_ foods: Food){
        self.food = foods
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(food)
    }
}

struct Food: Decodable, Hashable{
    var foodId: String
    var label: String
    var nutrients: parseNutrients
    
    func hash (into hasher: inout Hasher) {
        hasher.combine(foodId)
    }
}

struct parseNutrients: Decodable {
    var ENERC_KCAL: Float
    var PROCNT: Float
    var FAT: Float
    var CHOCDF: Float
}
extension Hints: Equatable {
    static func == (lhs: Hints, rhs: Hints) -> Bool {
        return lhs.food == rhs.food
    }
}

extension Food: Equatable {
    static func == (lhs: Food, rhs: Food) -> Bool {
        return lhs.foodId == rhs.foodId
    }
}
