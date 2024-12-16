//
//  EasyEntryApp.swift
//  EasyEntry
//
//  Created by Shashi Ranjan on 19/10/24.
//

import SwiftUI

@main
struct EasyEntryApp: App {

    @State private var isLoggedIn: Bool = false
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                DashboardView()
            }else {
               ContentView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
