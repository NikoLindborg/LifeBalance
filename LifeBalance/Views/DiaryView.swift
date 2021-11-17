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
    var body: some View {
        List{
            VStack(alignment: .leading){
                HStack{
                    ZStack {
                        VStack {
                            ProgressBar(progress: self.$progressValue, color: self.$color)
                                .frame(width: 50.0, height: 50.0)
                                .padding(40)
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationTitle("Daily Progress")
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
            .preferredColorScheme(.dark)
    }
}
