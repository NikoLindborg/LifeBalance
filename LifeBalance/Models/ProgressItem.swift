//
//  ProgressItem.swift
//  LifeBalance
//
//  Created by Aleksi Kosonen on 1.12.2021.
//
/*
Model for passing progress values as an array, to pass data more clearly and avoid non specific indexing
 */

import SwiftUI

struct ProgressItem: Identifiable {
    @State var id = UUID()
    @State var progress: Float
    @State var target: Float
    @State var consumed: Float
    @State var description: String
    @State var unit: String
}
