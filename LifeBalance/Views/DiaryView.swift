//
//  DiaryView.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 17.11.2021.
//
/*
 Diary View carries the same Daily Progress card that is displayed on the HomeView as well as a Meals section.
 
 In meals a MealCard is shown for each meal of the selected date, with the ingredients the user has added. The card works as a NavigationLink to EditView where the user can modify and save the inserted meal. 
 */

import SwiftUI

struct DiaryView: View {
    
    let persistenceController: PersistenceController
    @State var progressValues: Array<ProgressItem> = []
    @State var fullProgressValues: Array<ProgressItem> = []
    @ObservedObject var obMeals: ObservableMeals
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
                        // When picker value changes, the date is changed to be able to show past day's meals
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
                            DailyProgressCard(progressValues: $progressValues, color: $color, color2: $color, color3: $color, color4: $color)
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
                    // ForEach to show all meals and their ingredients in the view.
                    // Assigned an id for the items for the ForEach to work properly, as without it they wouldn't have unique indexes.
                    ForEach(obMeals.meals, id: \.self) {meal in
                        let ingr = (meal.ingredients?.allObjects as! [Ingredient])
                        NavigationLink(destination: EditMealView(meal: meal, ingredients: ingr, persistenceController: persistenceController, obMeals: obMeals, isUpdated: isUpdated), label: {
                            MealCard(meal: meal.mealType ?? "", food: ingr, backgroundColor: Color.LB_green)
                            }
                        )
                    }
                    .offset(y: -60)
                    .onChange(of: isUpdated.isUpdated, perform:  { (value) in
                        updateDate(date: obDays.allDays[selectedDayIndex].date ?? "")
                    })
                    Text("Tap a meal to edit ingredient amounts or save to My Foods")
                        .font(.footnote)
                        .padding(.bottom)
                }
            }
        }
        .onAppear(perform: {updateDate(date: itemFormatter.string(from: Date()))})
        .onAppear(perform: {getProgressValueToday(date: itemFormatter.string(from: Date()))})
        .onAppear(perform: {meals = obMeals.meals})
        .onAppear(perform: {selectedDayIndex = 0})
    }
    
    func getProgressValueToday(date: String) {
        // A dummy list for future reference for controlling what is shown on Daily Progress View
        let userSetNutritionalValues = ["calories", "carbohydrates", "protein", "fat"]
        progressValues = persistenceController.getProgressValues(userSetNutritionalValues, date: date)
        fullProgressValues = persistenceController.getProgressValues(nil, date: date)
    }
    
    func updateDate(date: String) {
        // This function gets all the meals for a specific date that is selected on the picker.
        // These meals are saved to the observedObject to be able to render them properly. 
        obMeals.meals = persistenceController.loadMealEntities(persistenceController.getDay(dateToCheck: date))
        self.meals = obMeals.meals
        getProgressValueToday(date: date)
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView(persistenceController: PersistenceController(), obMeals: ObservableMeals(), meals: ObservableMeals().meals, obDays: ObservableDays(), isUpdated: ObservableUpdate() )
    }
}

// Item formatter is being used to have only the date from the Date() as a string, for the app to save unique Day entities
let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
