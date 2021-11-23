//
//  HomeView.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 15.11.2021.
//

import SwiftUI

struct HomeView: View {
    @State var progressValue: Float = 0.25
    @State var color = Color.green
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("Today")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding(.leading, 28)
                    NavigationLink(destination: NutritionalDatalistView(), label: {
                        VStack(alignment: .leading){
                            DailyProgressCard(progressValue: $progressValue, color: $color, color2: $color, color3: $color, color4: $color)
                                .frame(width: 350, height: 250, alignment: .leading)
                                .background(Color.purple)
                                .cornerRadius(20)
                        }
                    })
                    NavigationLink(destination: AddMealView(), label: {
                        Text("Add new meal")
                            .font(.largeTitle)
                            .bold()
                            .padding(.leading, 10)
                            .frame(width: 350, height: 100, alignment: .leading)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    })
                }
                .offset(y: -60)
                VStack {
                    HStack {
                        Text("Trends")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding(.leading, 28)
                    TrendCard(cardCaption: "Iron", cardText: "Your iron levels are looking better than normal", color: Color.gray)
                    TrendCard(cardCaption: "D-vitamin", cardText: "You seem not to get enough vitamin D", color: Color.yellow)
                }
                .offset(y: -60)
                VStack {
                    HStack {
                        Text("Goals")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding(.leading, 28)
                    GoalsCard(cardCaption: "Weight", cardText: "Your weight was -0.5kg compared to last week", color: Color.green)
                }
                .offset(y: -60)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
