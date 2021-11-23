//
//  AddMealTabBar.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 23.11.2021.
//

import SwiftUI

struct AddMealTabBar: View {
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
                SearchView()
            case 1:
                Text("My foods")
            case 2:
                Text("Recent foods")
            default:
                Text("hai")
            }
            Spacer()
        }
    }
}

struct AddMealTabBar_Previews: PreviewProvider {
    static var previews: some View {
        AddMealTabBar()
    }
}
