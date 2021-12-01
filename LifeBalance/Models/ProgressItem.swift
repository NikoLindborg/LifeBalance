//
//  ProgressItem.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 1.12.2021.
//

import SwiftUI

struct ProgressItem: Identifiable {
    @State var id = UUID()
    @State var progress: Float
    @State var target: Float
    @State var consumed: Float
    @State var description: String
    @State var unit: String
}
