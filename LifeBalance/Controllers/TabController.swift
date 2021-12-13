//
//  TabController.swift
//  LifeBalance
//
//  Created by Jaani Kaukonen on 2.12.2021.
//
/*
 This controller is used for navigation between views without NavigationLink, to
 avoid constraint errors that they caused
*/

import SwiftUI

enum Tab {
    case home
    case diary
    case addMeal
    case settings
}

class TabController: ObservableObject {
    @Published var activeTab = Tab.home

    func open(_ tab: Tab) {
        activeTab = tab
    }
}
