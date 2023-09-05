/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Do Quang Thang
  ID: s3891873
  Created  date: 25/08/2020
  Last modified: 05/09/2023
  Acknowledgement: None
*/

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
            .environment(\.locale, Locale.init(identifier: GameService().language))
    }
}
