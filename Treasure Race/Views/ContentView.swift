//
//  ContentView.swift
//  Treasure Race
//
//  Created by Thang Do Quang on 25/08/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var game: GameService
    var body: some View {
        MenuView()
            .environment(\.locale, Locale.init(identifier: game.language))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameService())
            .environment(\.locale, Locale.init(identifier: "vi"))
    }
}
