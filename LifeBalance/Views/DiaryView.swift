//
//  DiaryView.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 17.11.2021.
//

import SwiftUI

struct DiaryView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(entity: Day.entity(), sortDescriptors: [], predicate: NSPredicate(format: "date != %@", Date() as CVarArg))
//
//    var days: FetchedResults<Day>
    
    @State var progressValue: Float = 0.25
    @State var color = Color.green
    @State var color2 = Color.blue
    @State var color3 = Color.orange
    @State var color4 = Color.red
    
    var body: some View {
        NavigationView {
        ScrollView{
            VStack{
                HStack{
                    Text("Daily Progress")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .offset(y: -60)
                .padding(.leading, 28)
                NavigationLink(destination: NutritionalDatalistView(), label: {
                    DailyProgressCard(progressValue: $progressValue, color: $color, color2: $color2, color3: $color3, color4: $color4)
                        .frame(width: 350, height: 250, alignment: .leading)
                        .cornerRadius(20.0)
                })
                    .offset(y: -60)
                HStack{
                    Text("My Meals")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .offset(y: -60)
                .padding(.leading, 28)
//                ForEach(days) { day in
//                    if (itemFormatter.string(from: day.date) == itemFormatter.string(from: Date())) {
//                        NavigationLink(destination: AddMealView(), label: {
//                            MealCard(meal: day.meal, food: ["Oatmeal", "cottage-cheese"], amount: ["400g", "200g"], backgroundColor: day.meal == "Breakfast" ? Color.gray : Color.green)
//                        })
//                    }
//                }
//                .offset(y: -60)
            }
        }
    }
}
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
