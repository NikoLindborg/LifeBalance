//
//  ProgressBar.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 17.11.2021.
//

/**
 This component is for circle progress bar and takes progress as variable to show correct value of progress
 */

import SwiftUI

struct ProgressBar: View {
    @Binding var progress: Float
    @Binding var color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 15.0)
                .opacity(0.3)
                .foregroundColor(self.color)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(self.color)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
        }
    }
}

