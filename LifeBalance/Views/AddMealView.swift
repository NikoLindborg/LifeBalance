//
//  AddMealView.swift
//  LifeBalance
//
//  Created by iosdev on 21.11.2021.
//

import SwiftUI

struct AddMealView: View {
    
    @EnvironmentObject var nutrientsParser: NutrientsParser
    @State var selectedTab: Int = 0
    @State private var selectedMealIndex = 0
    @State var addedFoods: [FoodModel] = []
    @State var mealEntities: [Meals] = []
    @EnvironmentObject private var tabController: TabController

    
    var meals = ["Breakfast", "Lunch", "Dinner", "Snack"]
    let persistenceController: PersistenceController
    
    
    var body: some View {
        NavigationView{
            VStack(
                alignment: .leading,
                spacing: 10) {
                    Section{
                        Picker(selection: $selectedMealIndex, label: Text("")) {
                            ForEach(0 ..< meals.count) {
                                Text(self.meals[$0])
                            }
                        }
                        Button(action: {
                            persistenceController.addMeal(meals[$selectedMealIndex.wrappedValue]){persistenceController.addFood(addedFoods, meals[$selectedMealIndex.wrappedValue])}
                            
                        }) {
                            Text("Add breakfast")
                                .font(.body)
                        }
                    }.frame(minWidth: 0/*@END_MENU_TOKEN@*/, idealWidth: 100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center)
                    
                    Button(action: {
                        var ingredients: [Ingredient] = []
                        mealEntities.forEach {meal in
                            ingredients.append(contentsOf: meal.ingredients?.allObjects as! [Ingredient])
                        }
                        
                        nutrientsParser.parseNutrients(ingredients[0].foodId ?? "", 300, "g"){
                            persistenceController.editFood(ingredients[0], 300, FoodModel(foodId: ingredients[0].foodId ?? "", label: ingredients[0].label ?? "", quantity: 300, totalNutrients: nutrientsParser.nutrientsList))
                        }
                    }) {
                        Text("Edit")
                            .font(.body)
                    }
                    Section {
                        VStack(){
                            Form{
                                List(addedFoods) {
                                    FoodRow(food: $0.label, amount: $0.quantity)
                                }
                                NavigationLink( destination: SearchView(addedFoods: $addedFoods)) {
                                    Label("add", systemImage: "plus.circle")
                                }
                            }
                        }
                    }
                }.onAppear(perform: {
                    mealEntities = persistenceController.loadMealEntities(persistenceController.getToday())})
        }
    }
}






struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView(persistenceController: PersistenceController())
            .environmentObject(FoodParser())
            .environmentObject(NutrientsParser())
    }
}

