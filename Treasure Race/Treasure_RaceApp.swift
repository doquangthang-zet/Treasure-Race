//
//  Treasure_RaceApp.swift
//  Treasure Race
//
//  Created by Thang Do Quang on 25/08/2023.
//

import SwiftUI

@main
struct Treasure_RaceApp: App {
    @StateObject var game = GameService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(game)
        }
    }
}
