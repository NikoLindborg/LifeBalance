//
//  AddMealTabBar.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 23.11.2021.
//

import SwiftUI

struct AddMealTabBar: View {
    @State var selectedTab: Int = 0
    @Binding var addedFoods: [FoodModel]
    @State var query = ""
    @State private var isRecording = false
    private let speechRecognizer = SpeechRecognizer()
    
    var body: some View {
        
        VStack {
            Picker("", selection: $selectedTab) {
                Text("Add new").tag(0)
                Text("My foods").tag(1)
                Text("Recents").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            switch(selectedTab) {
            case 0:
                TextField("Search for food", text: $query).disableAutocorrection(true)
                NavigationLink(destination: SearchView(query: $query.wrappedValue, addedFoods: $addedFoods), label: {
                    Image(systemName: "magnifyingglass")
                })
                HStack{
                    Button(action: {
                        if(isRecording == false){
                            speechRecognizer.record(to: $query)
                            isRecording = true
                        } else{
                            print($query)
                            speechRecognizer.stopRecording()
                            isRecording = false
                        }
                    }){
                        if(isRecording == false){
                            Image(systemName: "mic")
                        }else{
                            Image(systemName: "mic.fill")
                        }
                        
                    }
                }.padding(.bottom)
                Section {
                    VStack(){
                        Form{
                            List(addedFoods) {
                                FoodRow(food: $0.label, amount: $0.quantity)
                            }
                        }
                    }
                }
            case 1:
                Text("My foods")
            default:
                Text("hai")
            }
            Spacer()
        }
    }
}

