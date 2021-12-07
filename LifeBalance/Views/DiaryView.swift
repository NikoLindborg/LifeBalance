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
    @ObservedObject var obMeals: ObservableMeals
    @State var color = Color.green
    @State var color2 = Color.blue
    @State var color3 = Color.orange
    @State var color4 = Color.red
    @State var meals: [Meals] = []
    let today = itemFormatter.string(from: Date())
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    HStack{
                        Text("Daily Progress")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .offset(y: -60)
                    .padding(.leading, 28)
                    NavigationLink(destination: NutritionalDatalistView(), label: {
                        VStack(alignment: .leading){
                            DailyProgressCard(progressValues: $progressValues, color: $color, color2: $color, color3: $color, color4: $color)
                                .frame(width: 350, height: 250, alignment: .leading)
                                .background(Color.purple)
                                .cornerRadius(20)
                        }
                    })
                        .offset(y: -60)
                    HStack{
                        Text("My Meals")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .offset(y: -60)
                    .padding(.leading, 28)
                    ForEach(meals) {meal in
                        let ingr = (meal.ingredients?.allObjects as! [Ingredient])
                        MealCard(meal: meal.mealType ?? "", food: ingr, backgroundColor: Color.green)
                    }
                    .offset(y: -60)
                }
            }
        }
        .onAppear(perform: getProgressValueToday)
        .onAppear(perform:{ meals = obMeals.meals})
    }
    
    func getProgressValueToday() {
        // A dummy list for future reference for controlling what is shown on Daily Progress View
        let userSetNutritionalValues = ["calories", "iron"]
        progressValues = persistenceController.getProgressValues(userSetNutritionalValues: userSetNutritionalValues, date: today)
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView(persistenceController: PersistenceController(), obMeals: ObservableMeals())
    }
}

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
