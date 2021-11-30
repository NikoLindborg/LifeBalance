//
//  DiaryView.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 17.11.2021.
//

import SwiftUI

struct DiaryView: View {
    
    let persistenceController: PersistenceController
    
    @State var progressValue: Float = 0.25
    @State var color = Color.green
    @State var color2 = Color.blue
    @State var color3 = Color.orange
    @State var color4 = Color.red
    
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
                        DailyProgressCard(progressValue: $progressValue, color: $color, color2: $color2, color3: $color3, color4: $color4)
                            .frame(width: 350, height: 250, alignment: .leading)
                            .cornerRadius(20.0)
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
                    let meals = persistenceController.loadMealEntities(persistenceController.getToday())
                    ForEach(meals) {meal in
                        let ingr = (meal.ingredients?.allObjects as! [Ingredient])
                        MealCard(meal: meal.mealType ?? "", food: ingr, backgroundColor: Color.green)
                    }
                    .offset(y: -60)
                }
            }
        }
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView(persistenceController: PersistenceController())
    }
}

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
