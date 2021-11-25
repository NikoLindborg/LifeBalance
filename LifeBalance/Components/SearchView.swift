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
    @State var quantity: String = ""
    @State var foodId: String = ""
    @State var measureURI = "g"
    
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
                nutrientsParser.parseNutrients($foodId.wrappedValue, Int($quantity.wrappedValue) ?? 100, "g")
                
            }) {
                Text("Add")
                    .font(.body)
            }
            List(parser.queryList) { item in
                Button(action: {
                    print(item.food.foodId)
                    self.foodId = item.food.foodId
                }){
                    Text(item.food.label)
                }
           }
        }.padding(50)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(FoodParser())
            .environmentObject(NutrientsParser())
    }
}
