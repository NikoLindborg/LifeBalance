//
//  AddMealView.swift
//  LifeBalance
//
//  Created by iosdev on 21.11.2021.
//
/*
 The first view for the meal adding process. This view carries the AddMealTabVar component which has the options for adding a new meal or one from saved meals.
 */

import SwiftUI

struct AddMealView: View {
    
    @EnvironmentObject var nutrientsParser: NutrientsParser
    @State var selectedTab: Int = 0
    @State private var selectedMealIndex = 0
    @State var addedFoods: [FoodModel] = []
    @ObservedObject var obDays: ObservableDays
    @ObservedObject var observableProgress: ObservableProgressValues
    @State var selectedDayIndex = 0
    @State var chosenDate =  itemFormatter.string(from: Date())
    @EnvironmentObject private var tabController: TabController
    
    var meals = ["Breakfast", "Lunch", "Dinner", "Snack"]
    let persistenceController: PersistenceController
    @ObservedObject var obMeals: ObservableMeals
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.LB_whiteBlack.ignoresSafeArea()
                VStack {
                    HStack(alignment: .top) {
                        Spacer()
                        Text("Add meal")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    HStack{
                        Picker("", selection: $selectedDayIndex) {
                            ForEach(0 ..< obDays.allDays.count) { i in
                                HStack{
                                    if(obDays.allDays[i].date == itemFormatter.string(from: Date())){
                                        Text("\(obDays.allDays[i].date ?? "") (today)")
                                    } else{
                                        Text("\(obDays.allDays[i].date ?? "")" )
                                    }
                                }
                            }
                        }.colorMultiply(Color.LB_text)
                            .onChange(of: selectedDayIndex, perform:  { (value) in
                                chosenDate = obDays.allDays[selectedDayIndex].date ?? chosenDate
                            })
                    }
                    Spacer()
                    VStack(){
                        AddMealTabBar(addedFoods: $addedFoods, persistenceController: persistenceController)
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
                            //  The meal is saved to CoreData via persistenceController for the pickers selection date. The add meal has a @escaping function as parameter, so that the addFood is being executed after the addMeal.
                            Button(action: {
                                persistenceController.addMeal(meals[$selectedMealIndex.wrappedValue], dateToCheck: chosenDate){persistenceController.addFood(addedFoods, meals[$selectedMealIndex.wrappedValue], dateToCheck: chosenDate)}
                                // Meals are also updated to the observableObject so they are immidiately rendered properly, and after that the application navigates to DiaryView where the meals can be viewed.
                                obMeals.update()
                                addedFoods.removeAll()
                                tabController.open(.diary)
                            }) {
                                Text("Add \(meals[$selectedMealIndex.wrappedValue])")
                                    .font(.body)
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 75, alignment: .leading)
                                    .background(addedFoods.count == 0 ? Color.gray : Color.LB_green)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .disabled(addedFoods.count == 0)
                                    .padding()
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .onAppear(perform: {selectedDayIndex = 0})
        .onDisappear(perform: {observableProgress.update()})
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView(obDays: ObservableDays(), observableProgress: ObservableProgressValues(), persistenceController: PersistenceController(), obMeals: ObservableMeals())
            .environmentObject(FoodParser())
            .environmentObject(NutrientsParser())
    }
}

