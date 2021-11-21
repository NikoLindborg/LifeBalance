//
//  AddMealView.swift
//  LifeBalance
//
//  Created by iosdev on 21.11.2021.
//

import SwiftUI

struct AddMealView: View {
    
    @State var selectedTab: Int = 0
    private var meals = ["Breakfast", "Lunch", "Dinner", "Snack"]
    @State private var selectedMealIndex = 0
    @State private var showTabBar = false
    
    struct Food: Identifiable {
        let name: String
        let amount: String
        let id = UUID()
    }
    @State var addedFoods = [Food(name: "Banana", amount: "100 g"), Food(name: "Apple", amount: "200 g")]
    
    var body: some View {
        
        VStack(spacing: 0) {
            Section(){
                NavigationView {
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
                }
            }
            Section() {
                VStack(){
                    Form{
                        List(addedFoods) {
                                Text($0.name)
                                Text($0.amount)
                        }
                        Button(action: {showTabBar.toggle()}) {
                            Text("Add more  >")
                                .font(.body)
                        }
                    }
                }
            }
            Section(){
                if(showTabBar){
                    tabBar()
                }
            }
        }
    }
}

struct tabBar: View {
    @State var selectedTab: Int = 0
    
    var body: some View {
        
        VStack {
            Picker("", selection: $selectedTab) {
                Text("Add new").tag(0)
                Text("My foods").tag(1)
                Text("Recent foods").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            switch(selectedTab) {
            case 0:
                addNew()
            case 1:
                Text("hei")
            case 2:
                Text("hui")
            default:
                Text("hai")
                
            }
            Spacer()
        }
    }
}

struct addNew: View {
    @State var food: String = ""
    @State var amount: String = ""
    
    var body: some View {
        VStack() {
            TextField("Food", text: $food).disableAutocorrection(true)
            HStack() {
                TextField("Amount", text: $amount).disableAutocorrection(true)
                Text("g")
            }
        }.padding(50)
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView()
    }
}

