//
//  NutrientBodyModel.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 24.11.2021.
//

import Foundation

struct NutrientBody: Codable {
    let ingredients: [Ingredient]
}

struct Ingredient: Codable {
    let quantity: Int
    let measureURI: String
    let foodId: String
}
