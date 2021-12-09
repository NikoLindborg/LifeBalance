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
            ZStack {
                Color.LB_whiteBlack.ignoresSafeArea()
                VStack {
                    HStack(alignment: .top) {
                        Spacer()
                        Text("Add meal")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                    }
                    Spacer()
                    VStack(){
                        AddMealTabBar(addedFoods: $addedFoods)
                    }
                    VStack{
                        VStack{
                            HStack {
                                Text("Mealtype:")
                                Spacer()
                                Picker(selection: $selectedMealIndex, label: Text("")) {
                                    ForEach(0 ..< meals.count) {
                                        Text(self.meals[$0])
                                    }
                                }
                                .colorMultiply(Color.LB_text)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 75, maxHeight: 75)
                            .padding([.trailing, .leading], 20)
                            Button(action: {
                                persistenceController.addMeal(meals[$selectedMealIndex.wrappedValue]){persistenceController.addFood(addedFoods, meals[$selectedMealIndex.wrappedValue])}
                                obMeals.update()
                                addedFoods.removeAll()
                            }) {
                                Text("Add \(meals[$selectedMealIndex.wrappedValue])")
                                    .font(.body)
                                    .bold()
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 75, maxHeight: 75)
                            .foregroundColor(.white)
                            .background(addedFoods.count == 0 ? Color.gray : Color.LB_purple)
                            .disabled(addedFoods.count == 0)
                        }
                    }
                }
                Spacer()
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

