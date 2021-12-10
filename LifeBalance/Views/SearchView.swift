//
//  SearchView.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 23.11.2021.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var parser: FoodParser
    @EnvironmentObject var nutrientsParser: NutrientsParser
    @EnvironmentObject private var tabController: TabController
    @State var query: String
    @State var quantity = ""
    @State var foodId: String = ""
    @State var measureURI = "g"
    @State var label = ""
    @Binding var addedFoods: [FoodModel]
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("Results for \(query)")
                .bold()
            List(parser.queryList) { item in
                Button(action: {
                    if(self.foodId == item.food.foodId){
                        self.foodId = ""
                    }else{
                        self.foodId = item.food.foodId
                    }
                    self.foodId = item.food.foodId
                    self.label = item.food.label
                }){
                    Text("\(item.food.label) \(Int(item.food.nutrients.ENERC_KCAL)) kcal, \(Int(item.food.nutrients.PROCNT)) protein, \(Int(item.food.nutrients.CHOCDF)) Carbs, \(Int(item.food.nutrients.FAT)) Fats" )
                        .foregroundColor(self.foodId == item.food.foodId ? Color.green : Color.LB_text)
                }
            }
            TextField("Choose amount", text: $quantity).disableAutocorrection(true)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            Button(action: {
                nutrientsParser.parseNutrients($foodId.wrappedValue, Int($quantity.wrappedValue) ?? 0, "g"){
                    addedFoods.append(FoodModel(foodId: foodId, label: label, quantity: Int($quantity.wrappedValue) ?? 0, totalNutrients: nutrientsParser.nutrientsList))
                    self.mode.wrappedValue.dismiss()
                }
            }) {
                Text("Add \(label)")
                    .font(.body)
                    .bold()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 75, alignment: .leading)
            .foregroundColor(.white)
            .background($quantity.wrappedValue == "" ? Color.gray : Color.LB_green)
            .cornerRadius(20)
            .disabled($quantity.wrappedValue == "")
            .padding()
        }
        .onAppear(perform: {parser.parseFood(query)})
    }
}

/**struct SearchView_Previews: PreviewProvider {
 static var previews: some View {
 SearchView(addedFoods: [Food(name: "Banana", amount: "400g")])
 .environmentObject(FoodParser())
 .environmentObject(NutrientsParser())
 }
 }**/
