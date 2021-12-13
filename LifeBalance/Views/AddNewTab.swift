//
//  AddNewTab.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 8.12.2021.
//
/*
 Tab which is shown on the AddMeal view if the user wants to add a new set of ingredients instead of a saved meal
 */

import SwiftUI

struct AddNewTab: View {
    @Binding var query: String
    @Binding var addedFoods: [FoodModel]
    @State private var isRecording = false
    private let speechRecognizer = SpeechRecognizer()
    
    var body: some View {
        HStack {
            TextField("Search for food", text: $query).disableAutocorrection(true)
                .frame(height:30)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .background(Color(.systemGray6))
                .cornerRadius(15)
            HStack{
                // A icon indicator for when the application is recording voice.
                Button(action: {
                    if (isRecording == false) {
                        speechRecognizer.record(to: $query)
                        isRecording = true
                    } else {
                        speechRecognizer.stopRecording()
                        isRecording = false
                    }
                }){
                    if (isRecording == false){
                        Image(systemName: "mic")
                            .frame(width: 30)
                    } else {
                        Image(systemName: "mic.fill")
                            .frame(width: 30)
                    }
                }
                // Navigationlink to transport the query data to SearchView where it is presented.
                NavigationLink(destination: SearchView(query: $query.wrappedValue, addedFoods: $addedFoods), label: {
                    Image(systemName: "magnifyingglass")
                        .frame(width: 30)
                })
            }
        }
        .padding(20)
        .background(Color.LB_whiteBlack)
        List(addedFoods) {
            FoodRow(food: $0.label, amount: $0.quantity)
                .listRowBackground(Color(.systemGray6))
        }
        .background(Color.LB_whiteBlack)
    }
}
