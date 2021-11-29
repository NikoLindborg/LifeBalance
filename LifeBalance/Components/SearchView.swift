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
    @State var query: String = ""
    @State var quantity = ""
    @State var foodId: String = ""
    @State var measureURI = "g"
    @State var label = ""
    @Binding var addedFoods: [FoodModel]
    
    var body: some View {
        
        VStack() {
            TextField("Search for food", text: $query).disableAutocorrection(true)
            Button(action: {
                parser.parseFood(query)
            }) {
                Text("Search")
                    .font(.body)
            }
            TextField("Choose amount", text: $quantity).disableAutocorrection(true)
            Button(action: {
                nutrientsParser.parseNutrients($foodId.wrappedValue, Int($quantity.wrappedValue) ?? 0, "g"){
                    addedFoods.append(FoodModel(id: foodId, label: label, quantity: Int($quantity.wrappedValue) ?? 0, totalNutrients: nutrientsParser.nutrientsList))
                }
            }) {
                Text("Add")
                    .font(.body)
            }
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
                        .foregroundColor(self.foodId == item.food.foodId ? Color.green : Color.black)
                }
            }
        }.padding(50)
    }
}

/**struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(addedFoods: [Food(name: "Banana", amount: "400g")])
            .environmentObject(FoodParser())
            .environmentObject(NutrientsParser())
    }
}**/
