//
//  Persistence.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 23.11.2021.
//

import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    let today = itemFormatter.string(from: Date())
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "lifebalance")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func loadUserSettings() -> [UserSettings] {
        let fetchRequest: NSFetchRequest<UserSettings> = UserSettings.fetchRequest()
        
        do{
            return  try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func saveUserSettings(gender: String, height: String, weight: String, theme: Bool, activityLevel: String, target: String, age: String) {
        let userSettings = UserSettings(context: container.viewContext)
        userSettings.gender = gender
        userSettings.height = height
        userSettings.weight = weight
        userSettings.theme = theme
        userSettings.target = target
        userSettings.activityLevel = activityLevel
        userSettings.age = age
        do {
            try container.viewContext.save()
        } catch {
            return print("Failed to save gender \(error)")
        }
    }
    
    func updateUserSettings(userSettings: [UserSettings], gender: String, height: String, weight: String, target: String, activitylevel: String, age: String, theme: Bool) {
        if(!userSettings.isEmpty ) {
            if(!gender.isEmpty){
                userSettings[0].gender = gender
            }
            if(!height.isEmpty){
                userSettings[0].height = height
            }
            if(!weight.isEmpty) {
                userSettings[0].weight = weight
            }
            if(!target.isEmpty) {
                userSettings[0].target = target
            }
            if(!activitylevel.isEmpty) {
                userSettings[0].activityLevel = activitylevel
            }
            if(!age.isEmpty) {
                userSettings[0].age = age
            }
            userSettings[0].theme = theme
        }
        do {
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
    }
    
    func loadDayEntities() -> [Day] {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        do {
            return  try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func loadIngredientEntities() -> [Ingredient] {
        let fetchRequest: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        do{
            return try container.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    
    func loadMealEntities(_ day: Day?) -> [Meals] {
        let fetchRequest: NSFetchRequest<Meals> = Meals.fetchRequest()
        do {
            var mealList = try container.viewContext.fetch(fetchRequest)
            if (day != nil) {
                mealList = mealList.filter {$0.day?.date == day?.date}
            }
            if (day == nil) {
                mealList = []
            }
            return mealList
        } catch {
            return []
        }
    }
    
    func addDay(date: String) {
        if (checkIfExists(argument: date, nil)) {
            let days: Day? = Day(context: container.viewContext)
            days?.date = date
            days?.id = UUID()
            do {
                try container.viewContext.save()
                return print("Save today success")
            } catch {
                return print("Failed to save today \(error)")
            }
        }
    }
    
    func addMeal(_ mealName: String, dateToCheck: String, finished: @escaping() -> Void ) {
        if (checkIfExists(argument: dateToCheck, nil)) {
            let days: Day? = Day(context: container.viewContext)
            days?.date = dateToCheck
            if (checkIfExists(argument: mealName, days)) {
                let meal = Meals(context: container.viewContext)
                meal.mealType = mealName
                meal.day = days
                do {
                    try container.viewContext.save()
                    finished()
                    return print("Save meal success")
                } catch {
                    finished()
                    return print("Failed to save date \(error)")
                }
            }
        } else {
            let dayEntities = loadDayEntities()
            let dayEntity = dayEntities.filter {$0.date == dateToCheck}
            if (checkIfExists(argument: mealName, dayEntity[0])) {
                let meal = Meals(context: container.viewContext)
                meal.mealType = mealName
                do {
                    meal.day = dayEntity[0]
                    try container.viewContext.save()
                    finished()
                    return print("Day entity meal success")
                } catch {
                    finished()
                    return print("Failed to save meal \(error)")
                }
            }
            finished()
        }
    }
    
    func checkIfExists(argument: String, _ day: Day?) -> Bool {
        var test = true
        if (day == nil) {
            let allDays = loadDayEntities()
            if (allDays.count > 0 ){
                allDays.forEach{day in
                    if (day.date == argument) {
                        test = false
                    }
                }
            }
        } else {
            let allMeals = loadMealEntities(day)
            if (allMeals.count > 0 ){
                allMeals.forEach{meal in
                    if (meal.mealType == argument) {
                        test = false
                    }
                }
            }
            
        }
        
        return test
    }
    
    func addFood(_ addedFoodList: [FoodModel], _ mealName: String, dateToCheck: String) {
        let allDays = loadDayEntities()
        let dayEntity = allDays.filter {$0.date == dateToCheck}
        
        let mealEntities = loadMealEntities(dayEntity[0])
        let mealEntity = mealEntities.filter {$0.mealType == mealName}
        
        addedFoodList.forEach {food in
            let ingredient = Ingredient(context: container.viewContext)
            ingredient.meal = mealEntity[0]
            ingredient.foodId = food.foodId
            ingredient.identifier = UUID()
            ingredient.label = food.label
            ingredient.quantity = Int16(food.quantity)
            
            for n in 1...9 {
                let nutrient = Nutrition(context: container.viewContext)
                if n == 1 {
                    nutrient.label = "calories"
                    nutrient.quantity = food.totalNutrients[0].ENERC_KCAL?.quantity ?? 0
                    nutrient.ingredient = ingredient
                    nutrient.unit = food.totalNutrients[0].ENERC_KCAL?.unit
                }
                if n == 2 {
                    nutrient.label = "fat"
                    nutrient.quantity = food.totalNutrients[0].FAT?.quantity ?? 0
                    nutrient.ingredient = ingredient
                    nutrient.unit = food.totalNutrients[0].FAT?.unit
                }
                if n == 3 {
                    nutrient.label = "carbohydrates"
                    nutrient.quantity = food.totalNutrients[0].CHOCDF?.quantity ?? 0
                    nutrient.ingredient = ingredient
                    nutrient.unit = food.totalNutrients[0].CHOCDF?.unit
                }
                if n == 4 {
                    nutrient.label = "protein"
                    nutrient.quantity = food.totalNutrients[0].PROCNT?.quantity ?? 0
                    nutrient.ingredient = ingredient
                    nutrient.unit = food.totalNutrients[0].PROCNT?.unit
                }
                if n == 5 {
                    nutrient.label = "fiber"
                    nutrient.quantity = food.totalNutrients[0].FIBTG?.quantity ?? 0
                    nutrient.ingredient = ingredient
                    nutrient.unit = food.totalNutrients[0].FIBTG?.unit
                }
                if n == 6 {
                    nutrient.label = "sugar"
                    nutrient.quantity = food.totalNutrients[0].SUGAR?.quantity ?? 0
                    nutrient.ingredient = ingredient
                    nutrient.unit = food.totalNutrients[0].SUGAR?.unit
                }
                if n == 7 {
                    nutrient.label = "sodium"
                    nutrient.quantity = food.totalNutrients[0].NA?.quantity ?? 0
                    nutrient.ingredient = ingredient
                    nutrient.unit = food.totalNutrients[0].NA?.unit
                }
                if n == 8 {
                    nutrient.label = "cholesterol"
                    nutrient.quantity = food.totalNutrients[0].CHOLE?.quantity ?? 0
                    nutrient.ingredient = ingredient
                    nutrient.unit = food.totalNutrients[0].CHOLE?.unit
                }
                if n == 9 {
                    nutrient.label = "iron"
                    nutrient.quantity = food.totalNutrients[0].FE?.quantity ?? 0
                    nutrient.ingredient = ingredient
                    nutrient.unit = food.totalNutrients[0].FE?.unit
                }
            }
        }
        do {
            try container.viewContext.save()
            return print("Ingredient save success")
        } catch {
            return print("Failed to save ingredients \(error)")
        }
    }
    
    func getDay(dateToCheck: String) -> Day? {
        let allDays = loadDayEntities()
        let dayEntity = allDays.filter {$0.date == dateToCheck}
        return dayEntity.count > 0 ? dayEntity[0]: nil
    }
    
    func createRefValuesEntity() {
        let refValuesEntity = getRefValues()
        if (refValuesEntity.count > 0) {
            print("RefValues already exists")
        } else {
            _ = CDReferenceValues(context: container.viewContext)
            do {
                try container.viewContext.save()
                return print("Reference values created to CoreData")
            } catch {
                return print("Failed to create reference values to CoreData \(error)")
            }
        }
    }
    
    func addRefValues(refCalories: Double, refIron: Double, refFat: Double, refCarbohydrates: Double, refProtein: Double, refFiber: Double, refSugar: Double, refSodium: Double) {
        let refValues = getRefValues()
        refValues[0].ref_calories = refCalories
        refValues[0].ref_iron = refIron
        refValues[0].ref_fat = refFat
        refValues[0].ref_carbohydrates = refCarbohydrates
        refValues[0].ref_protein = refProtein
        refValues[0].ref_fiber = refFiber
        refValues[0].ref_sugar = refSugar
        refValues[0].ref_sodium = refSodium
        do {
            try container.viewContext.save()
            return print("Reference values \(refIron) & \(refCalories) & prot \(refProtein) & carbs \(refCarbohydrates) & fat \(refFat) &  stored to CoreData")
        } catch {
            return print("Failed to save reference values to CoreData \(error)")
        }
    }
    
    func getRefValues() -> Array<CDReferenceValues> {
        let fetchRequest: NSFetchRequest<CDReferenceValues> = CDReferenceValues.fetchRequest()
        do {
            return  try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func getRefValuesDictionary() -> Dictionary<String, Float> {
        let userReferenceValues: Dictionary<String, Float> = [
            "calories" : Float(getRefValues()[0].ref_calories),
            "iron" : Float(getRefValues()[0].ref_iron),
            "sodium" : Float(getRefValues()[0].ref_sodium),
            "protein" : Float(getRefValues()[0].ref_protein),
            "fiber" : Float(getRefValues()[0].ref_fiber),
            "fat" : Float(getRefValues()[0].ref_fat),
            "carbohydrates" : Float(getRefValues()[0].ref_carbohydrates),
            "sugar" : Float(getRefValues()[0].ref_sugar),
            
        ]
        
        return userReferenceValues
    }
    
    func getConsumedMealNutrients(nutritionLabel: String, date: String) -> (value: Float?, unit: String?) {
        let meals = loadMealEntities(getDay(dateToCheck: date))
        var value: Float = 0
        var unit: String = ""
        meals.forEach {meal in
            let ingr = (meal.ingredients?.allObjects as! [Ingredient])
            ingr.forEach {ing in
                let nutrition = (ing.nutrients?.allObjects as! [Nutrition])
                nutrition.forEach {nutr in
                    if (nutr.label == nutritionLabel) {
                        value += nutr.quantity
                        unit = nutr.unit ?? ""
                    }
                }
            }
        }
        return (value, unit)
    }
    
    func getProgressValues(_ userSetNutritionalValues: Array<String>?, date: String) -> Array<ProgressItem> {
        var progressArray: Array<ProgressItem> = []
        let userReferenceValues = getRefValuesDictionary()
        let nutritionalValues = userSetNutritionalValues ?? ["calories", "carbohydrates", "protein", "fat", "iron", "sugar", "sodium", "iron"]
        nutritionalValues.forEach {userValue in
            let consumedNutrient = getConsumedMealNutrients(nutritionLabel: userValue, date: date)
            let userReferenceForValue = userReferenceValues[userValue] ?? 0.0
            let result: Float? = (consumedNutrient.value ?? 0.0) / userReferenceForValue
            progressArray.append(ProgressItem(progress: result ?? 0.0, target: userReferenceForValue, consumed: consumedNutrient.value ?? 0.0, description: userValue, unit: consumedNutrient.unit ?? ""))
        }
        return progressArray
    }
    
    func getSpecificMeal(mealType: String, meals: [Meals]) -> Meals{
        return meals.filter{$0.mealType == mealType}[0]
    }
    
    func editFood(_ ingred: Ingredient,_ quantity: Int, _ food: FoodModel) {
        
        ingred.quantity = Int16(quantity)
        if (ingred.quantity <= 0){
            container.viewContext.delete(ingred)
        } else {
            print(ingred.quantity)
            let nutrients = ingred.nutrients
            
            let nutrientsArray = nutrients?.allObjects as! [Nutrition]
            nutrientsArray.forEach{ nutrient in
                if nutrient.label == "calories" {
                    nutrient.quantity = food.totalNutrients[0].ENERC_KCAL?.quantity ?? 0
                    nutrient.unit = food.totalNutrients[0].ENERC_KCAL?.unit
                }
                
                if nutrient.label == "fat" {
                    nutrient.quantity = food.totalNutrients[0].FAT?.quantity ?? 0
                    nutrient.unit = food.totalNutrients[0].FAT?.unit
                }
                
                if nutrient.label == "carbohydrates" {
                    nutrient.quantity = food.totalNutrients[0].CHOCDF?.quantity ?? 0
                    nutrient.unit = food.totalNutrients[0].CHOCDF?.unit
                }
                
                if nutrient.label == "protein" {
                    nutrient.quantity = food.totalNutrients[0].PROCNT?.quantity ?? 0
                    nutrient.unit = food.totalNutrients[0].PROCNT?.unit
                }
                
                if nutrient.label == "fiber" {
                    nutrient.quantity = food.totalNutrients[0].FIBTG?.quantity ?? 0
                    nutrient.unit = food.totalNutrients[0].FIBTG?.unit
                }
                
                if nutrient.label == "sugar" {
                    nutrient.quantity = food.totalNutrients[0].SUGAR?.quantity ?? 0
                    nutrient.unit = food.totalNutrients[0].SUGAR?.unit
                }
                
                if nutrient.label == "sodium" {
                    nutrient.quantity = food.totalNutrients[0].NA?.quantity ?? 0
                    nutrient.unit = food.totalNutrients[0].NA?.unit
                }
                
                if nutrient.label == "cholesterol" {
                    nutrient.quantity = food.totalNutrients[0].CHOLE?.quantity ?? 0
                    nutrient.unit = food.totalNutrients[0].CHOLE?.unit
                }
                
                if nutrient.label == "iron"{
                    nutrient.quantity = food.totalNutrients[0].FE?.quantity ?? 0
                    nutrient.unit = food.totalNutrients[0].FE?.unit
                }
            }
        }
        do {
            try container.viewContext.save()
            return print("Ingredient save success")
        } catch {
            return print("Failed to save ingredients \(error)")
        }
    }
    
    func getTrendSettings () -> [TrendSettings] {
        let fetchRequest: NSFetchRequest<TrendSettings> = TrendSettings.fetchRequest()
        
        do {
            return  try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func initializeTrends() {
        if(getTrendSettings().count != 0){
            return
        }
        
        let trends = TrendSettings(context: container.viewContext)
        
        trends.trend_calories = true
        trends.trend_protein = true
        trends.trend_carbs = true
        trends.trend_sugar = false
        trends.trend_salt = false
        trends.trend_iron = false
        do {
            try container.viewContext.save()
            return print("Initializing trends success")
        } catch {
            return print("Failed to initialize trends \(error)")
        }
    }
    
    func getTrendValuesDictionary() -> Dictionary<String, Bool> {
        let userTrendValues: Dictionary<String, Bool> = [
            "calories" : getTrendSettings()[0].trend_calories,
            "carbs" : getTrendSettings()[0].trend_carbs,
            "protein" : getTrendSettings()[0].trend_protein,
            "sugar" : getTrendSettings()[0].trend_sugar,
            "salt" : getTrendSettings()[0].trend_salt,
            "iron" : getTrendSettings()[0].trend_iron
        ]
        return userTrendValues
    }
    
    func modifyTrends (calories: Bool, carbs: Bool, protein: Bool, sugar: Bool, salt: Bool, iron: Bool) {
        let trends = getTrendSettings()[0]
        
        trends.trend_calories = calories
        trends.trend_carbs = carbs
        trends.trend_protein = protein
        trends.trend_sugar = sugar
        trends.trend_salt = salt
        trends.trend_iron = iron
        
        do {
            try container.viewContext.save()
            return print("Saving new trends success")
        } catch {
            return print("Failed to save new trends \(error)")
        }
    }
    
    func getDailyProgressCoreData () -> [DailyProgressCoreData] {
        let fetchRequest: NSFetchRequest<DailyProgressCoreData> = DailyProgressCoreData.fetchRequest()
        
        do {
            return  try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func initializeDailyProgressCoreData() {
        
        if (getDailyProgressCoreData().count != 0){
            return
        }
        
        let dailyProgressSettings = DailyProgressCoreData(context: container.viewContext)
        dailyProgressSettings.daily_calories = true
        dailyProgressSettings.daily_fat = true
        dailyProgressSettings.daily_iron = false
        dailyProgressSettings.daily_carbs = true
        dailyProgressSettings.daily_protein = true
        dailyProgressSettings.daily_sodium = false
        dailyProgressSettings.daily_sugar = false
        
        do {
            try container.viewContext.save()
            return print("Initializing daily progress settings success")
        } catch {
            return print("Failed to initialize daily progress settings \(error)")
        }
    }
    
    func modifyDailyProgress (calories: Bool, carbs: Bool, protein: Bool, sugar: Bool, salt: Bool, iron: Bool, fat: Bool, finished: @escaping() -> Void ) {
        let dailyProgressSettings = getDailyProgressCoreData()[0]
        
        dailyProgressSettings.daily_calories = calories
        dailyProgressSettings.daily_carbs = carbs
        dailyProgressSettings.daily_protein = protein
        dailyProgressSettings.daily_sugar = sugar
        dailyProgressSettings.daily_sodium = salt
        dailyProgressSettings.daily_iron = iron
        dailyProgressSettings.daily_fat = fat
        
        do {
            try container.viewContext.save()
            finished()
            return print("Saving new daily progress success")
        } catch {
            return print("Failed to save new daily progress \(error)")
        }
    }
    func getAllIngredients() -> [Ingredient] {
        let fetchRequest: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        do {
            return  try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    
    func getIngredients(meal: Meals) -> FetchedResults<Ingredient>{
        @FetchRequest(
            entity: Ingredient.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Ingredient.meal, ascending: true),
            ],
            predicate: NSPredicate(format: "meal == %@", meal)
        ) var fetchedIngredieents: FetchedResults<Ingredient>
        return fetchedIngredieents
    }
    
    func getAllSavedMeals() -> [Saved]{
        let fetchRequest: NSFetchRequest<Saved> = Saved.fetchRequest()
        do {
            return  try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func saveMeal (name: String, meal: Meals) {
        let save = Saved(context: container.viewContext)
        let allSaved = getAllSavedMeals()
        let sameName = allSaved.filter{$0.mealName == name}
        if(sameName.count > 0){
            return print("\(name) as name is already taken")
        }
        var ingredients = getAllIngredients()
        print(ingredients.count)
        let ingr = (meal.ingredients?.allObjects as! [Ingredient])
        var ingre: [Ingredient] = []
        ingr.forEach{ ingredient in
            ingre = ingredients.filter  {$0.identifier == ingredient.identifier }
            print(ingredients[0].identifier == ingredient.identifier)
        }
        ingredients = Array(Set(ingre))
        ingredients.forEach {e in
            e.saved = save
        }
        print(ingredients)
        save.mealName = name
        
        do {
            try container.viewContext.save()
            return print("Saving meal \(name) succeed")
        } catch {
            return print("Saving meal \(name) failed: \(error)")
        }
    }
}
