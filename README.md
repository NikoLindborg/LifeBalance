# LifeBalance

Team project for Metropolia UAS IOS-development course.

Authors: Niko Lindborg, Aleksi Kosonen, Aleksi Kytö, Jaani Kaukonen and Jon Nesten

# About LifeBalance

LifeBalance is a tool for balancing one aspect in your life: Nutrition. 

In LifeBalance the user can add consumed meals to the applications diary and the application calculates the nutritional values of the daily consumed meals. 

The user can decide which nutrient values she or he wants to track, for example Iron, Calories or Protein. These values are presented in the Daily Progress card in a user-friendly manner. 

The application also carries a trend feature where specific nutrient values are analysed on a three day period and the user is presented with a verbal feedback of hers or his current situation for that value.

LifeBalance also supports Apple's Health Data and displays a graph of the user's active calories and step count from past 7 days from Apple Health. 

# Installation

1. Make sure you have Xcode installed
```
This Application is developed with SwiftUI and need XCode for building. 

Xcode can be downloaded via the Mac App Store. 
```

2. Clone the repo
```
https://github.com/NikoLindborg/LifeBalance.git
```

3. Add Health Data to your Xcode simulator (not necessary, but the application doesn't have any Health Data to display without this step)
```
- Open "Health" in the iOS simulator
- Add "Steps" data from the first page by clicking from the "No data", then "Add data" from the upper right corner
- Navigate to "Browse" tab from bottom navigation
- Click "Activity" and "Active energy" from the detail view
- Click "Add data" from the upper right corner to add Active Energy data
```

4. Run the Application!
```
Hit "Run" on Xcode and start balancing your life!
```
