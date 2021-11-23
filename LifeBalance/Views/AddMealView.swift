//
//  AddMealView.swift
//  LifeBalance
//
//  Created by iosdev on 21.11.2021.
//

import SwiftUI

struct AddMealView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var selectedTab: Int = 0
    private var meals = ["Breakfast", "Lunch", "Dinner", "Snack"]
    @State private var selectedMealIndex = 0
    
    struct Food: Identifiable {
        let name: String
        let amount: String
        let id = UUID()
    }
    @State var addedFoods = [Food(name: "Banana", amount: "100 g"), Food(name: "Apple", amount: "200 g")]
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 10) {
                Section(){
                    Form{
                        Section{
                            Picker(selection: $selectedMealIndex, label: Text("")) {
                                ForEach(0 ..< meals.count) {
                                    Text(self.meals[$0])
                                }
                            }
                        }
                    }
                    .navigationTitle("")
                }.frame(minWidth: 0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center)
                Section() {
                    VStack(){
                        Form{
                            List(addedFoods) {
                                Text($0.name)
                                Text($0.amount)
                            }
                            Button(action: {
                                let newDay = Day(context: viewContext)
                                newDay.mealName = .breakfast
                                newDay.date = Date()
                                do {
                                    try viewContext.save()
                                    print("Breakfast saved.")
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }) {
                                Text("Add breakfast")
                                    .font(.body)
                            }
                            Button(action: {
                                let newDay = Day(context: viewContext)
                                newDay.mealName = .lunch
                                newDay.date = Date()
                                do {
                                    try viewContext.save()
                                    print("Lunch saved.")
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }) {
                                Text("Add lunch")
                                    .font(.body)
                            }
                        }
                    }
                    Section(){
                        AddMealTabBar()
                    }
                }
            }
    }
}






struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView()
            .environmentObject(FoodParser())
    }
}

