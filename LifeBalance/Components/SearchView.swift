//
//  SearchView.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 23.11.2021.
//

import SwiftUI

struct SearchView: View {
    @State var query: String = ""
    @State var amount: String = ""
    @EnvironmentObject var parser: FoodParser
    
    
    var body: some View {
        
        VStack() {
            TextField("Search for food", text: $query).disableAutocorrection(true)
            Button(action: {
                //parser.parseFood(query)
                print("hei, ", parser.queryList[0].food)
            }) {
                Text("Search")
                    .font(.body)
            }
            List(parser.queryList) { item in
                Button(action: {
                    print(item.food.foodId)
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
    }
}
