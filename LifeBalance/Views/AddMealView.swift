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
    let today = itemFormatter.string(from: Date())
    @ObservedObject var obMeals: ObservableMeals
    
    
    var body: some View {
        NavigationView{
            VStack(
                alignment: .leading,
                spacing: 10) {
             
                        HStack{
                            Spacer()
                            VStack{
                                Picker(selection: $selectedMealIndex, label: Text("")) {
                                    ForEach(0 ..< meals.count) {
                                        Text(self.meals[$0])
                                    }
                                }
                                Button(action: {
                                    persistenceController.addMeal(meals[$selectedMealIndex.wrappedValue]){persistenceController.addFood(addedFoods, meals[$selectedMealIndex.wrappedValue])}
                                    obMeals.update()
                                    
                                }) {
                                    Text("Add breakfast")
                                        .font(.body)
                                }
                            }
                            
                            Spacer()
                        }
                        Spacer()

                    Section {
                        VStack(){
                            AddMealTabBar(addedFoods: $addedFoods)
                        }
                    }
                }.onAppear(perform: {
                    mealEntities = persistenceController.loadMealEntities(persistenceController.getDay(dateToCheck: today))})
        }
    }
}






struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView(persistenceController: PersistenceController(), obMeals: ObservableMeals())
            .environmentObject(FoodParser())
            .environmentObject(NutrientsParser())
    }
}

