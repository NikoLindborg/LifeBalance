# LifeBalance

Team project for Metropolia UAS IOS-development course.

Authors: Niko Lindborg, Aleksi Kosonen, Aleksi Kytö, Jaani Kaukonen and Jon Nesten

# About LifeBalance

LifeBalance is a tool for balancing one aspect in your life: Nutrition. 

In LifeBalance the user can add consumed meals to the applications diary and the application calculates the nutritional values of the daily consumed meals. 

The user can decide which nutrient values she or he wants to track, for example Iron, Calories or Protein. These values are presented in the Daily Progress card in a user-friendly manner. 

The application also carries a trend feature where specific nutrient values are analysed on a three day period and the user is presented with a verbal feedback of hers or his current situation for that value.

LifeBalance also supports Apple's Health Data and displays a graph of the user's active calories and step count from past 7 days from Apple Health. 

## Adding a meal in light mode

![home_light](https://user-images.githubusercontent.com/61407571/145851163-22266250-18e2-4842-95ee-05f6628bd5aa.png)&nbsp;&nbsp;&nbsp;&nbsp;
![add_meal_light](https://user-images.githubusercontent.com/61407571/145851232-df4acc5d-6a10-4a94-94ba-21e7b71b949d.png)&nbsp;&nbsp;&nbsp;&nbsp;
![diary_light](https://user-images.githubusercontent.com/61407571/145851288-71c751a7-8f0a-489f-96d3-fcdcb1e75f76.png)&nbsp;&nbsp;&nbsp;&nbsp;

## HomeView in dark mode

![home_dark](https://user-images.githubusercontent.com/61407571/145851583-f80decf9-60f7-4c99-8102-c2064ba929fe.png)&nbsp;&nbsp;&nbsp;&nbsp;
![trends_dark](https://user-images.githubusercontent.com/61407571/145851575-c06dd513-1d12-47e4-b409-9c40e0c19b0a.png)&nbsp;&nbsp;&nbsp;&nbsp;
![activity_dark](https://user-images.githubusercontent.com/61407571/145851586-ca4b7775-37fb-4dbe-9c42-4a5ace5eb83a.png)&nbsp;&nbsp;&nbsp;&nbsp;

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
