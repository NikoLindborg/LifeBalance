//
//  ParsedModel.swift
//  LifeBalance
//
//
//  Datamodels for FoodParser api calls, has multiple structs that are only used in the same api calls datamodels
//  Created by Niko Lindborg on 22.11.2021.
//

import Foundation

struct ParsedModel: Decodable {
    var hints: [Hints]
}

struct Hints: Decodable, Identifiable {
    var id: String{food.foodId}
    var food: Food
}

struct Food: Decodable{
    var foodId: String
    var label: String
    var nutrients: parseNutrients
}

struct parseNutrients: Decodable {
    var ENERC_KCAL: Int
    var PROCNT: Double
    var FAT: Double
    var CHOCDF: Double
}
