//
//  GameTypeView.swift
//  Treasure Race
//
//  Created by Thang Do Quang on 26/08/2023.
//

import SwiftUI

struct GameTypeView: View {
    @EnvironmentObject var game: GameService
    @State private var gameType: GameType = .undetermined
    @State private var yourName: String = ""
    @State private var opponentName: String = ""
    @FocusState private var focus: Bool
    @State private var startGame: Bool = false
    
    var body: some View {
        VStack {
            Picker("Select Game", selection: $gameType) {
                Text("Choose game type").tag(GameType.undetermined)
                Text("Play with machine").tag(GameType.bot)
                Text("2 Player").tag(GameType.single)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(lineWidth: 2))
            
            Text(gameType.description)
                .padding()
            
            VStack{
                switch gameType {
                case .single:
                    VStack{
                        TextField("Your name", text: $yourName)
                        TextField("Opponent name", text: $opponentName)
                    }
                case .bot:
                    TextField("Your name", text: $yourName)
                case .undetermined:
                    EmptyView()
                }
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .focused($focus)
            .frame(width: 350)
            
            Button ("Start Game") {
                game.setupGame(gameType: gameType, player1Name: yourName, player2Name: opponentName)
                focus = false
                startGame = true
            }
            .buttonStyle(.borderedProminent)
            .disabled(
                gameType == .undetermined ||
                gameType == .bot && yourName.isEmpty ||
                gameType == .single && (yourName.isEmpty || opponentName.isEmpty)
            )
            Spacer()
        }
        .navigationTitle("Treasure Race")
        .fullScreenCover(isPresented: $startGame){
            GameView()
        }
        .inNavigationStack()
    }
}

struct GameTypeView_Previews: PreviewProvider {
    static var previews: some View {
        GameTypeView()
            .environmentObject(GameService())
    }
}
