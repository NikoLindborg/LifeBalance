//
//  EditMealView.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 8.12.2021.
//

import SwiftUI
import Foundation

struct EditMealView: View {
    var meal: Meals
    var ingredients: [Ingredient]
    let persistenceController: PersistenceController
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var nutrientsParser: NutrientsParser
    @ObservedObject var obMeals: ObservableMeals
    @ObservedObject var isUpdated: ObservableUpdate
    @State var newAmount: String = ""
    @State var saveMealName: String = ""
    @State var selectedIngredient: String = ""
    
    var body: some View {
        HStack {
            Text("Edit meal")
                .font(.largeTitle)
                .bold()
            Spacer()
        }
        .padding()
        let ingredients = (meal.ingredients?.allObjects as! [Ingredient])
        if (ingredients.count > 0) {
            ForEach(0 ..< ingredients.count) {ingredient in
                if (ingredients.indices.contains(ingredient)) {
                    Button(action: {self.selectedIngredient = ingredients[ingredient].label ?? ""}){
                        EditItems(food: ingredients[ingredient].label ?? "", amount: String(ingredients[ingredient].quantity))
                    }
                    if (selectedIngredient == ingredients[ingredient].label) {
                        HStack{
                            TextField("Change amount to \(ingredients[ingredient].label ?? "")", text: $newAmount)
                                .frame(height:30)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                                .background(Color(.systemGray6))
                                .cornerRadius(15)
                            Button(action: {
                                isUpdated.notUpdated()
                                nutrientsParser.parseNutrients(ingredients[ingredient].foodId ?? "", Int($newAmount.wrappedValue) ?? 0, "g"){
                                    persistenceController.editFood(ingredients[ingredient], Int($newAmount.wrappedValue) ?? 0, FoodModel(foodId: ingredients[ingredient].foodId ?? "", label: ingredients[ingredient].label ?? "", quantity: Int($newAmount.wrappedValue) ?? 0, totalNutrients: nutrientsParser.nutrientsList))
                                    obMeals.update()
                                    isUpdated.updated()
                                }
                                self.mode.wrappedValue.dismiss()
                            })
                            {
                                Text("Change")
                            }
                        }
                        .padding()
                    }
                }
            }
            Spacer()
            HStack {
                Text("Save to My Foods")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding()
            HStack {
                TextField("Meal name", text: $saveMealName)
                    .frame(height:30)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                Button("Save"){
                    persistenceController.saveMeal(name: saveMealName, meal: meal)
                }
            }
            .padding()
            Spacer()
        }
    }
}

class ObservableUpdate: ObservableObject {
    @Published var isUpdated: Bool
    
    init(){
        self.isUpdated = false
    }
    
    func updated() {
        self.isUpdated = true
    }
    
    func notUpdated() {
        self.isUpdated = false
    }
}
