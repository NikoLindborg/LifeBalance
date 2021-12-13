//
//  SavedMealsTab.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 8.12.2021.
//

import SwiftUI

struct SavedMealsTab: View {
    @State var savedMeals: [Saved] = []
    @Binding var addedFoods: [FoodModel]
    let persistenceController: PersistenceController
    var body: some View {
        Section {
            if (savedMeals.count > 0) {
                List(savedMeals){ item in
                    HStack{
                        VStack{
                            Button(action: {addSelected(meal: item)}){
                                HStack{
                                    Text(item.mealName ?? "")
                                        .foregroundColor(Color.LB_text)
                                    Spacer()
                                    let ingr = (item.ingredients?.allObjects as! [Ingredient])
                                    ForEach(ingr){ ingredient in
                                        VStack{
                                            HStack{
                                                Text("\u{2022} \(ingredient.label ?? "")" )
                                                    .foregroundColor(Color.LB_text)
                                                Spacer()
                                                Text("\(ingredient.quantity )g" )
                                                    .foregroundColor(Color.LB_text)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .listRowBackground(Color(.systemGray6))
                }
            } else {
                Spacer()
                Text("No saved meals yet. You can save a added meal in Diary")
                    .font(.footnote)
                Spacer()
            }
        }
        .listStyle(InsetGroupedListStyle())
        .onAppear(perform: {savedMeals = persistenceController.getAllSavedMeals()})
    }
    func addSelected(meal: Saved) {
        print(meal)
        let ingr = (meal.ingredients?.allObjects as! [Ingredient])
        ingr.forEach{ ingredient in
            let nutrients = (ingredient.nutrients?.allObjects as! [Nutrition])
            addedFoods.append(FoodModel(foodId: ingredient.foodId ?? "", label: ingredient.label ?? "", quantity: Int(ingredient.quantity) , totalNutrients: parseNutrients(nutrients: nutrients)))
        }
    }
    
    func parseNutrients(nutrients: [Nutrition]) -> [totalNutrients] {
        var total: [totalNutrients] = []
        var enerc_kcal: ENERC_KCAL?
        var fat: FAT?
        var chocdf: CHOCDF?
        var procnt: PROCNT?
        var fibtg: FIBTG?
        var sugar: SUGAR?
        var na: NA?
        var chole: CHOLE?
        var fe: FE?
        
        nutrients.forEach{ nutrient in
            if(nutrient.label == "calories"){
                enerc_kcal = (ENERC_KCAL(label: "ENERC_KCAL", quantity: nutrient.quantity, unit: "kcal"))
            }
            if(nutrient.label == "fat"){
                fat = (FAT(label: "FAT", quantity: nutrient.quantity, unit: "g"))
            }
            if(nutrient.label == "carbohydrates"){
                chocdf = (CHOCDF(label: "CHOCDF", quantity: nutrient.quantity, unit: "g"))
            }
            if(nutrient.label == "protein"){
                procnt = (PROCNT(label: "PROCNT", quantity: nutrient.quantity, unit: "g"))
            }
            if(nutrient.label == "fiber"){
                fibtg = (FIBTG(label: "FIBTG", quantity: nutrient.quantity, unit: "g"))
            }
            if(nutrient.label == "sugar"){
                sugar = (SUGAR(label: "SUGAR", quantity: nutrient.quantity, unit: "g"))
            }
            if(nutrient.label == "sodium"){
                na = (NA(label: "NA", quantity: nutrient.quantity, unit: "g"))
            }
            if(nutrient.label == "cholesterol"){
                chole = (CHOLE(label: "CHOLE", quantity: nutrient.quantity, unit: "mg"))
            }
            if(nutrient.label == "iron"){
                fe = (FE(label: "FE", quantity: nutrient.quantity, unit: "mg"))
            }
        }
        total.append(totalNutrients(ENERC_KCAL: enerc_kcal, FAT: fat, CHOCDF: chocdf, PROCNT: procnt, FIBTG: fibtg, SUGAR: sugar, NA: na, CHOLE: chole, FE: fe))
        return total
    }
}
/**
 struct SavedMealsTab_Previews: PreviewProvider {
 static var previews: some View {
 SavedMealsTab(addedFoods:, persistenceController: PersistenceController())
 }
 }*/
