//
//  DiaryView.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 17.11.2021.
//

import SwiftUI

struct DiaryView: View {
    @State var progressValue: Float = 0.25
    @State var color = Color.green
    @State var color2 = Color.blue
    @State var color3 = Color.orange
    @State var color4 = Color.red
    var body: some View {
        List{
            VStack{
                Text("Daily Progress")
                    .font(.title)
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        ZStack {
                            VStack {
                                ProgressBar(progress: self.$progressValue, color: self.$color)
                                    .frame(width: 50.0, height: 50.0)
                                    .padding(20)
                                Text("Protein 50 / 200")
                                Spacer()
                                ProgressBar(progress: self.$progressValue, color: self.$color2)
                                    .frame(width: 50.0, height: 50.0)
                                    .padding(20)
                                Text("Carbs 50 / 200")
                                Spacer()
                            }
                        }
                        Spacer()
                        Spacer()
                        Spacer()
                        VStack {
                            ProgressBar(progress: self.$progressValue, color: self.$color3)
                                .frame(width: 50.0, height: 50.0)
                                .padding(20)
                            Text("Fats 50 / 200")
                            Spacer()
                            ProgressBar(progress: self.$progressValue, color: self.$color4)
                                .frame(width: 50.0, height: 50.0)
                                .padding(20)
                            Text("Protein 50 / 200")
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
            .background(Color(red:0.45, green: 0.32, blue:0.59))
        }
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
            .preferredColorScheme(.dark)
    }
}
