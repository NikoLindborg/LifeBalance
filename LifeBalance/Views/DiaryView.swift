//
//  DiaryView.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 17.11.2021.
//

import SwiftUI

struct DiaryView: View {
    
    let persistenceController: PersistenceController
    
    @State var progressValues: Array<ProgressItem> = []
    @State var fullProgressValues: Array<ProgressItem> = []
    @ObservedObject var obMeals: ObservableMeals
    @ObservedObject var dailyProgressSettings: ObservableDailyProgress
    @State var color = Color.green
    @State var color2 = Color.blue
    @State var color3 = Color.orange
    @State var color4 = Color.red
    @State var meals: [Meals]
    @ObservedObject var obDays: ObservableDays
    @State var selectedDayIndex = 0
    @ObservedObject var isUpdated: ObservableUpdate
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
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
                            updateDate(date: obDays.allDays[selectedDayIndex].date ?? "")
                        })
                    }
                    .padding(.bottom, 46)
                    HStack{
                        Text("Daily Progress")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .offset(y: -60)
                    .padding(.leading)
                    
                    NavigationLink(destination: NutritionalDatalistView(progressItems: $fullProgressValues), label: {
                        VStack(alignment: .leading){
                            DailyProgressCard(progressSettings: dailyProgressSettings, color: $color, color2: $color, color3: $color, color4: $color)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: 350)
                                .background(Color.LB_purple)
                                .cornerRadius(20)
                        }
                        .padding([.trailing, .leading])
                    })
                        .offset(y: -60)
                    HStack{
                        Text("My Meals")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .offset(y: -60)
                    .padding(.leading)
                    ForEach(obMeals.meals, id: \.self) {meal in
                        let ingr = (meal.ingredients?.allObjects as! [Ingredient])
                        NavigationLink(destination: EditMealView(meal: meal, ingredients: ingr, persistenceController: persistenceController, obMeals: obMeals, isUpdated: isUpdated), label: {
                            MealCard(meal: meal.mealType ?? "", food: ingr, backgroundColor: Color.green)
                            }
                        )
                    }
                    .offset(y: -60)
                    .onChange(of: isUpdated.isUpdated, perform:  { (value) in
                        print("changed")
                        updateDate(date: obDays.allDays[selectedDayIndex].date ?? "")
                    })
                    Text("Tap a meal to edit ingredient amounts or save to My Foods")
                        .font(.footnote)
                        .padding(.bottom)
                }
            }
        }
        //.onAppear(perform: {getProgressValueToday(date: itemFormatter.string(from: Date()))})
        /*.onChange(of: isUpdated.isUpdated) {value in
            updateDate(date: itemFormatter.string(from: Date()))
        }*/
        //.onChange(of: {isUpdated.isUpdated}, perform: {updateDate(date: itemFormatter.string(from: Date()))})
        .onAppear(perform: {updateDate(date: itemFormatter.string(from: Date()))})
        .onAppear(perform: {getProgressValueToday(date: itemFormatter.string(from: Date()))})
        .onAppear(perform: {meals = obMeals.meals})
        .onAppear(perform: {selectedDayIndex = 0})
    }
    
    func getProgressValueToday(date: String) {
        // A dummy list for future reference for controlling what is shown on Daily Progress View
        let userSetNutritionalValues = ["calories", "carbs", "protein", "fat"]
        progressValues = persistenceController.getProgressValues(userSetNutritionalValues, date: date)
        fullProgressValues = persistenceController.getProgressValues(nil, date: date)
    }
    
    func updateDate(date: String) {
        obMeals.meals = persistenceController.loadMealEntities(persistenceController.getDay(dateToCheck: date))
        self.meals = obMeals.meals
        getProgressValueToday(date: date)
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView(persistenceController: PersistenceController(), obMeals: ObservableMeals(),dailyProgressSettings: ObservableDailyProgress(), meals: ObservableMeals().meals, obDays: ObservableDays(), isUpdated: ObservableUpdate() )
    }
}

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
