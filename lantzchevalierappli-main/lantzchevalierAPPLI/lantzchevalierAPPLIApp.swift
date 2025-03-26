//
//  lantzchevalierAPPLIApp.swift
//  lantzchevalierAPPLI
//
//  Created by Nathan Lantz on 9/13/24.
//

import SwiftUI

@main
struct lantzchevalierAPPLIApp: App {
    @StateObject var userChoices = UserChoices()
    var body: some Scene {
            WindowGroup {
                ContentView()
                    .environmentObject(userChoices)
            }
    }
}
