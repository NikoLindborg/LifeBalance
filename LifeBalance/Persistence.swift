//
//  Persistence.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 23.11.2021.
//

import CoreData

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
    
    func loadDayEntities() -> [Day] {
        let fetchRequest: NSFetchRequest<Day> = Day.fetchRequest()
        do {
            return  try container.viewContext.fetch(fetchRequest)
        } catch {
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
            return mealList
        } catch {
            return []
        }
    }
    
    func updateUserSettings() {
        do {
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
    }
    
    func addMeal(_ mealName: String, finished: @escaping() -> Void ) {
        let dateToCheck = itemFormatter.string(from: Date())
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
    
    func addFood(_ addedFoodList: [FoodModel], _ mealName: String) {
        let dateToCheck = itemFormatter.string(from: Date())
        let allDays = loadDayEntities()
        let dayEntity = allDays.filter {$0.date == dateToCheck}
        
        let mealEntities = loadMealEntities(dayEntity[0])
        let mealEntity = mealEntities.filter {$0.mealType == mealName}
        
        addedFoodList.forEach {food in
            let ingredient = Ingredient(context: container.viewContext)
            ingredient.meal = mealEntity[0]
            ingredient.foodId = food.foodId
            ingredient.id = UUID()
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
    
    func getToday() -> Day? {
        let dateToCheck = itemFormatter.string(from: Date())
        let allDays = loadDayEntities()
        let dayEntity = allDays.filter {$0.date == dateToCheck}
        return dayEntity.count > 0 ? dayEntity[0]: nil
    }
}
