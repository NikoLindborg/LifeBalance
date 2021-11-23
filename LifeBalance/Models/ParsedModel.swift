//
//  ParsedModel.swift
//  LifeBalance
//
//
//  Datamodel for FoodParser api calls
//  Created by Niko Lindborg on 22.11.2021.
//

import Foundation

struct ParsedModel: Decodable, Identifiable {
    var id = UUID()
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
