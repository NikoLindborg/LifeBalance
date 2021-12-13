//
//  NutrientsParserDataModels.swift
//  LifeBalance
//
//
//  File for nutrients parser endpoints datamodels, these are only used in this file
//  Created by Niko Lindborg on 23.11.2021.
//

/**
 Datamodels for NutrientsParser api calls, has multiple structs that are used for the same api calls datamodels.
 Also contains FoodModel, which is a model class used for creating food objects, and inserting them into the core-data.
 */

import Foundation

struct NutrientsModel: Decodable {
    var totalNutrients: totalNutrients
}

struct FoodModel: Identifiable {
    var foodId: String
    var id: UUID = UUID()
    var label: String
    var quantity: Int
    var totalNutrients: [totalNutrients]
}

struct totalNutrients: Decodable {
    var ENERC_KCAL: ENERC_KCAL?
    var FAT: FAT?
    var CHOCDF: CHOCDF?
    var PROCNT: PROCNT?
    var FIBTG: FIBTG?
    var SUGAR: SUGAR?
    var NA: NA?
    var CHOLE: CHOLE?
    var FE: FE?
}

struct ENERC_KCAL: Decodable {
    var label: String
    var quantity: Float
    var unit: String
}

struct FAT: Decodable {
    var label: String
    var quantity: Float
    var unit: String
}

struct CHOCDF: Decodable {
    var label: String
    var quantity: Float
    var unit: String
}

struct PROCNT: Decodable {
    var label: String
    var quantity: Float
    var unit: String
}

struct FIBTG: Decodable {
    var label: String
    var quantity: Float
    var unit: String
}

struct SUGAR: Decodable {
    var label: String
    var quantity: Float
    var unit: String
}

struct NA: Decodable {
    var label: String
    var quantity: Float
    var unit: String
}

struct CHOLE: Decodable {
    var label: String
    var quantity: Float
    var unit: String
}

struct FE: Decodable {
    var label: String
    var quantity: Float
    var unit: String
}
