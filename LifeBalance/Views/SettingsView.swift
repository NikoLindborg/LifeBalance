//
//  SettingsView.swift
//  LifeBalance
//
//  Created by iosdev on 21.11.2021.
//

import SwiftUI

struct SettingsView: View {
    
    let persistenceController: PersistenceController
    
    @State private var uSettings: [UserSettings] = [UserSettings]()
    @State private var needsRefresh: Bool = false
    
    @State private var isSaved = false
    
    var genders = ["Male", "Female", "Undefined"]
    var weight = ["80", "81", "82", "83", "84", "85"]
    var height = ["180", "181", "182", "183", "184", "185"]
    var activitylevel = ["Super active", "Active", "Normal", "Lazy", "Dad"]
    var target = ["Weight loss", "Muscle gain", "Healthy lifestyle", "Staying alive"]
    
    @State private var selectedFrameworkIndexGender = ""
    @State private var selectedFrameworkIndexWeight = ""
    @State private var selectedFrameworkIndexHeight = ""
    @State private var selectedFrameworkIndexActivity = ""
    @State private var selectedFrameworkIndexTarget = ""
    
    @State private var lightMode = true
    
    func loadSettings() {
        uSettings = persistenceController.loadUserSettings()
        if(!uSettings.isEmpty){
            isSaved = true
            if(selectedFrameworkIndexWeight == "") {
                selectedFrameworkIndexWeight = uSettings[0].weight ?? ""
            }
            if(selectedFrameworkIndexHeight == "") {
                selectedFrameworkIndexHeight = uSettings[0].height ?? ""
            }
            if(selectedFrameworkIndexGender == "") {
                selectedFrameworkIndexGender = uSettings[0].gender ?? ""
            }
            if(selectedFrameworkIndexActivity == "") {
                selectedFrameworkIndexActivity = uSettings[0].activityLevel ?? ""
            }
            if(selectedFrameworkIndexTarget == "") {
                selectedFrameworkIndexTarget = uSettings[0].target ?? ""
            }
        }
    }
    
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
                        ForEach(weight, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker(selection: $selectedFrameworkIndexHeight, label: Text("Height")) {
                        ForEach(height, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker(selection: $selectedFrameworkIndexGender, label: Text("Gender")) {
                        ForEach(genders, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker(selection: $selectedFrameworkIndexActivity, label: Text("Acitivity level")) {
                        ForEach(activitylevel, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker(selection: $selectedFrameworkIndexTarget, label: Text("Target")) {
                        ForEach(target, id: \.self) {
                            Text($0)
                        }
                    }
                    Button(action: {
                        if(!isSaved){
                            persistenceController.saveUserSettings(gender: selectedFrameworkIndexGender, height: selectedFrameworkIndexHeight, weight: selectedFrameworkIndexWeight, theme: lightMode,
                                                                   activityLevel: selectedFrameworkIndexActivity, target: selectedFrameworkIndexTarget)
                        } else {
                            if(!selectedFrameworkIndexGender.isEmpty){
                                uSettings[0].gender = selectedFrameworkIndexGender
                            }
                            if(!selectedFrameworkIndexHeight.isEmpty){
                                uSettings[0].height = selectedFrameworkIndexHeight
                            }
                            if(!selectedFrameworkIndexWeight.isEmpty) {
                                uSettings[0].weight = selectedFrameworkIndexWeight
                            }
                            if(!selectedFrameworkIndexTarget.isEmpty) {
                                uSettings[0].target = selectedFrameworkIndexTarget
                            }
                            if(!selectedFrameworkIndexActivity.isEmpty) {
                                uSettings[0].activityLevel = selectedFrameworkIndexActivity
                            }
                            persistenceController.updateUserSettings()
                            needsRefresh.toggle()
                        }
                        loadSettings()
                    }) {
                        if(!isSaved){
                            Text("Save").font(.body)
                        } else {
                            Text("Update")
                                .font(.body)
                        }
                        
                    }
                }/*accentcolor used only to "activate" needsRefresh*/
                .accentColor(needsRefresh ? .blue: .blue)
            }
            .navigationTitle("Settings")
            .onAppear(perform: {
                loadSettings()
            })
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(persistenceController: PersistenceController())
    }
}
