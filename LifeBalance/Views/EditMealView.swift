//
//  EditMealView.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 8.12.2021.
//

import SwiftUI

struct EditMealView: View {
    var meal: Meals
    @State var newAmount: String = ""
    var ingredients: [Ingredient]
    let persistenceController: PersistenceController
    @EnvironmentObject var nutrientsParser: NutrientsParser
    @ObservedObject var obMeals: ObservableMeals
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        let ingr = (meal.ingredients?.allObjects as! [Ingredient])

        ForEach(0 ..< ingr.count) {ingredient in
            MealItems(food: ingr[ingredient].label ?? "", amount: String(ingr[ingredient].quantity))
                .background(Color.green)
            TextField("Change amount", text: $newAmount)
            Button(action: {
                nutrientsParser.parseNutrients(ingr[ingredient].foodId ?? "", Int($newAmount.wrappedValue) ?? 0, "g"){
                    persistenceController.editFood(ingr[ingredient], Int($newAmount.wrappedValue) ?? 0, FoodModel(foodId: ingr[ingredient].foodId ?? "", label: ingr[ingredient].label ?? "", quantity: Int($newAmount.wrappedValue) ?? 0, totalNutrients: nutrientsParser.nutrientsList))
                }
                obMeals.update()
                self.mode.wrappedValue.dismiss()
            })
                {
                Text("Change")
            }
        }

    }
}
