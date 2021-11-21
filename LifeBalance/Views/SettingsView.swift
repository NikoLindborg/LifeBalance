//
//  SettingsView.swift
//  LifeBalance
//
//  Created by iosdev on 21.11.2021.
//

import SwiftUI

struct SettingsView: View {
    
    var genders = ["Male", "Female", "Undefined"]
    var weight = ["80", "81", "82", "83", "84", "85"]
    var height = ["180", "181", "182", "183", "184", "185"]
    var activitylevel = ["Super active", "Active", "Normal", "Lazy", "Dad"]
    var target = ["Weight loss", "Muscle gain", "Healthy lifestyle", "Staying alive"]
    
    @State private var selectedFrameworkIndexGender = 0
    @State private var selectedFrameworkIndexWeight = 0
    @State private var selectedFrameworkIndexHeight = 0
    @State private var selectedFrameworkIndexActivity = 0
    @State private var selectedFrameworkIndexTarget = 0
    
    @State private var lightMode = true
    
    var body: some View {
        
        NavigationView {
            Form{
                Section(header: Text("Display")){
                    Toggle(isOn: $lightMode, label: {
                        Text("Light mode")
                    })
                }
                Section(header: Text("Your info"), footer: Text("We use this data to calculate the correct daily intakes")){
                    Picker(selection: $selectedFrameworkIndexWeight, label: Text("Weight")) {
                                        ForEach(0 ..< weight.count) {
                                            Text(self.weight[$0])
                                        }
                                    }
                    Picker(selection: $selectedFrameworkIndexHeight, label: Text("Height")) {
                                        ForEach(0 ..< height.count) {
                                            Text(self.height[$0])
                                        }
                                    }
                    Picker(selection: $selectedFrameworkIndexGender, label: Text("Gender")) {
                                        ForEach(0 ..< genders.count) {
                                            Text(self.genders[$0])
                                        }
                                    }
                    Picker(selection: $selectedFrameworkIndexActivity, label: Text("Acitivity level")) {
                                        ForEach(0 ..< activitylevel.count) {
                                            Text(self.activitylevel[$0])
                                        }
                                    }
                    Picker(selection: $selectedFrameworkIndexTarget, label: Text("Target")) {
                                        ForEach(0 ..< target.count) {
                                            Text(self.target[$0])
                                        }
                                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
