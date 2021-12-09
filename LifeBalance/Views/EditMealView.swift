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
    @State var newAmount: String = ""
    var ingredients: [Ingredient]
    let persistenceController: PersistenceController
    @EnvironmentObject var nutrientsParser: NutrientsParser
    @ObservedObject var obMeals: ObservableMeals
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var isUpdated: ObservableUpdate
    @State var selectedIngredient: String = ""
    
    var body: some View {
        let ingr = (meal.ingredients?.allObjects as! [Ingredient])
        if (ingr.count > 0) {
            ForEach(0 ..< ingr.count) {ingredient in
                if (ingr.indices.contains(ingredient)) {
                    Button(action: {self.selectedIngredient = ingr[ingredient].label ?? ""}){
                        EditItems(food: ingr[ingredient].label ?? "", amount: String(ingr[ingredient].quantity))
                    }
                    if (selectedIngredient == ingr[ingredient].label) {
                        HStack{
                            TextField("Change amount to \(ingr[ingredient].label ?? "")", text: $newAmount)
                            Button(action: {
                                isUpdated.notUpdated()
                                nutrientsParser.parseNutrients(ingr[ingredient].foodId ?? "", Int($newAmount.wrappedValue) ?? 0, "g"){
                                    persistenceController.editFood(ingr[ingredient], Int($newAmount.wrappedValue) ?? 0, FoodModel(foodId: ingr[ingredient].foodId ?? "", label: ingr[ingredient].label ?? "", quantity: Int($newAmount.wrappedValue) ?? 0, totalNutrients: nutrientsParser.nutrientsList))
                                    obMeals.update()
                                    isUpdated.updated()
                                }
                                self.mode.wrappedValue.dismiss()
                            })
                            {
                                Text("Change")
                            }
                        }.padding()
                    }
                }
            }
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
