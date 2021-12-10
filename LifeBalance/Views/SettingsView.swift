//
//  SettingsView.swift
//  LifeBalance
//
//  Created by iosdev on 21.11.2021.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var testCal: Double = 0
    let persistenceController: PersistenceController
     
    @State private var uSettings: [UserSettings] = [UserSettings]()
    @State private var cdRefValues: [CDReferenceValues] = [CDReferenceValues]()
        
    @State private var isSaved = false
    
    let referenceValues = ReferenceValues()
    
    var genders = ["Male", "Female", "Undefined"]
    var weight = (40...160).map{"\($0)"}
    var height = (140...210).map{"\($0)"}
    var age = (15...80).map{"\($0)"}
    var activitylevel = ["Very active", "Active", "Moderately active", "Lightly active", "Sedentary"]
    var target = ["Weight loss", "Muscle gain", "Healthy lifestyle"]
    
    @State private var selectedFrameworkIndexGender = ""
    @State private var selectedFrameworkIndexWeight = ""
    @State private var selectedFrameworkIndexHeight = ""
    @State private var selectedFrameworkIndexActivity = ""
    @State private var selectedFrameworkIndexTarget = ""
    @State private var selectedFrameworkIndexAge = ""
    
    @State private var lightMode = true
    @Binding var themeColor: ColorScheme
        
    func updateSettings() {
        if(!isSaved){
            persistenceController.saveUserSettings(gender: selectedFrameworkIndexGender, height: selectedFrameworkIndexHeight, weight: selectedFrameworkIndexWeight, theme: lightMode,
                                                activityLevel: selectedFrameworkIndexActivity, target: selectedFrameworkIndexTarget, age: selectedFrameworkIndexAge)
        } else {
            persistenceController.updateUserSettings(userSettings: uSettings, gender: selectedFrameworkIndexGender, height: selectedFrameworkIndexHeight, weight: selectedFrameworkIndexWeight, target: selectedFrameworkIndexTarget, activitylevel: selectedFrameworkIndexActivity, age: selectedFrameworkIndexAge, theme: lightMode)
        }
        loadSettings()
        if(referenceValues.calories != 0){
            persistenceController.addRefValues(refCalories: referenceValues.calories, refIron: referenceValues.iron, refFat: referenceValues.fat, refCarbohydrates: referenceValues.carbohydrates, refProtein: referenceValues.protein, refFiber: referenceValues.fiber, refSugar: referenceValues.sugar, refSodium: referenceValues.sodium)
        }
    }
    
    func loadSettings() {
        uSettings = persistenceController.loadUserSettings()
        //can remove later
        cdRefValues = persistenceController.getRefValues()
        //
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
            if(selectedFrameworkIndexAge == "") {
                selectedFrameworkIndexAge = uSettings[0].age ?? ""
            }
            lightMode = uSettings[0].theme
            referenceValues.getReferenceValues(height: uSettings[0].height ?? "", weight: uSettings[0].weight ?? "", age: uSettings[0].age ?? "", gender: uSettings[0].gender ?? "", activity: uSettings[0].activityLevel ?? "",target: uSettings[0].target ?? "")
            
            //can remove later
            if(!cdRefValues.isEmpty){
                testCal = cdRefValues[0].ref_calories
            }
            //
            
        }else {
            lightMode = themeColor == .light ? true : false
        }
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Display")){
                    Toggle("Lightmode", isOn: $lightMode).onChange(of: lightMode){value in
                        themeColor = value ? .light : .dark // This gets the theme changed, BUT after changing theme you can't change it again or edit any other settings.
                        updateSettings()
                    }
                }
                .listRowBackground(Color(.systemGray6))
                Section(header: Text("Your info"), footer: Text("We use this data to calculate the correct daily intakes")){
                    Picker(selection: $selectedFrameworkIndexWeight, label: Text("Weight")) {
                        ForEach(weight, id: \.self) {
                            Text($0)
                        }.onChange(of: selectedFrameworkIndexWeight){value in
                            updateSettings()
                        }
                    }
                    Picker(selection: $selectedFrameworkIndexHeight, label: Text("Height")) {
                        ForEach(height, id: \.self) {
                            Text($0)
                        }.onChange(of: selectedFrameworkIndexHeight){value in
                            updateSettings()
                        }
                    }
                    Picker(selection: $selectedFrameworkIndexGender, label: Text("Gender")) {
                        ForEach(genders, id: \.self) {
                            Text($0)
                        }.onChange(of: selectedFrameworkIndexGender){value in
                            updateSettings()
                        }
                    }
                    Picker(selection: $selectedFrameworkIndexAge, label: Text("Age")) {
                        ForEach(age, id: \.self) {
                            Text($0)
                        }.onChange(of: selectedFrameworkIndexAge){value in
                            updateSettings()
                        }
                    }
                    Picker(selection: $selectedFrameworkIndexActivity, label: Text("Acitivity level")) {
                        ForEach(activitylevel, id: \.self) {
                            Text($0)
                        }.onChange(of: selectedFrameworkIndexActivity){value in
                            updateSettings()
                        }
                    }
                    Picker(selection: $selectedFrameworkIndexTarget, label: Text("Target")) {
                        ForEach(target, id: \.self) {
                            Text($0)
                        }.onChange(of: selectedFrameworkIndexTarget){value in
                            updateSettings()
                        }
                    }
                }
                .listRowBackground(Color(.systemGray6))
                Text("Required calories intake: \(testCal, specifier: "%.2f") kcal")
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
        
        SettingsView(persistenceController: PersistenceController(), themeColor: .constant(.dark))
    }
}
