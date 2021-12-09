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
        List(savedMeals){ item in
            HStack{
                VStack{
                    Button(action: {addSelected(meal: item)}){
                        Text(item.mealName ?? "")
                        let ingr = (item.ingredients?.allObjects as! [Ingredient])
                        ForEach(ingr){ ingredient in
                            VStack{
                                HStack{
                                    Text("\u{2022} \(ingredient.label ?? "")" )
                                    Text("\(ingredient.quantity )g" )
                                }
                            }
                            
                            
                        }
                    }.colorMultiply(.black)
                }
            }
            
        } .listStyle(InsetGroupedListStyle())
            .onAppear(perform: {savedMeals = persistenceController.getAllSavedMeals()})
            .onAppear(perform: {
                print(savedMeals[0].ingredients)
                let ingr = savedMeals[0].ingredients?.allObjects as! [Ingredient]
                print(String(ingr[0].label ?? ""))
            })
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
                enerc_kcal?.label = "ENERC_KCAL"
                enerc_kcal?.quantity = nutrient.quantity
                enerc_kcal?.unit = "kcal"
            }
            if(nutrient.label == "fat"){
                enerc_kcal?.label = "FAT"
                enerc_kcal?.quantity = nutrient.quantity
                enerc_kcal?.unit = "g"
            }
            if(nutrient.label == "carbohydrates"){
                enerc_kcal?.label = "CHOCDF"
                enerc_kcal?.quantity = nutrient.quantity
                enerc_kcal?.unit = "g"
            }
            if(nutrient.label == "protein"){
                enerc_kcal?.label = "PROCNT"
                enerc_kcal?.quantity = nutrient.quantity
                enerc_kcal?.unit = "g"
            }
            if(nutrient.label == "fiber"){
                enerc_kcal?.label = "FIBTG"
                enerc_kcal?.quantity = nutrient.quantity
                enerc_kcal?.unit = "g"
            }
            if(nutrient.label == "sugar"){
                enerc_kcal?.label = "SUGAR"
                enerc_kcal?.quantity = nutrient.quantity
                enerc_kcal?.unit = "g"
            }
            if(nutrient.label == "sodium"){
                enerc_kcal?.label = "NA"
                enerc_kcal?.quantity = nutrient.quantity
                enerc_kcal?.unit = "g"
            }
            if(nutrient.label == "cholesterol"){
                enerc_kcal?.label = "CHOLE"
                enerc_kcal?.quantity = nutrient.quantity
                enerc_kcal?.unit = "mg"
            }
            if(nutrient.label == "iron"){
                enerc_kcal?.label = "FE"
                enerc_kcal?.quantity = nutrient.quantity
                enerc_kcal?.unit = "mg"
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
