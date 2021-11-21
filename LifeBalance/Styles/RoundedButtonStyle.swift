//
//  RoundedButtonStyle.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 19.11.2021.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .frame(width: 350, height: 100, alignment: .leading)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(20)
    }
}
