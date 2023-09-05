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

// MARK: - GAME UI View
struct GameView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var game: GameService
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: Bool
    
    var body: some View {
        //MARK: BODY
        ZStack{
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("Color-orange-light"), Color("Color-light-yellow")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            
            //MARK: - VSTACK
            VStack{
                //MARK: - PLAYER TURN CHOOSING
                VStack {
                    if[game.player1.isCurrent, game.player2.isCurrent].allSatisfy({ $0 == false }) {
                        Text("choose-player-go-first")
                    }
                    HStack{
                        //MARK: - BUTTON PLAYER NAME
                        Button(game.player1.name) {
                            game.player1.isCurrent = true
                            playSound(sound: "twink", type: "mp3")
                        }
                        .buttonStyle(PlayerBtnStyle(isCurrent: game.player1.isCurrent))
                        
                        Button(game.player2.name) {
                            game.player2.isCurrent = true
                            if game.gameType == .bot {
                                Task {
                                    await game.iphoneMove()
                                }
                            }
                            
                        }
                        .buttonStyle(PlayerBtnStyle(isCurrent: game.player2.isCurrent))
                    }
                    .disabled(game.gameStart)
                }
                
                //MARK: - PLAYER-2 AREA
                HStack{
                    //MARK: - DICE
                    Button {
                        game.makeMove()
                        playSound(sound: "diceroll", type: "mp3")
                        do {
                            sleep(1)
                        }
                        if game.possibleMoves == false {
                            playSound(sound: "negative", type: "mp3")
                        } else if game.getBomb == true {
                            playSound(sound: "explotion", type: "mp3")
                        } else if game.getPortal == true {
                            playSound(sound: "teleport", type: "mp3")
                        } else if game.isKicked == true {
                            playSound(sound: "aha", type: "mp3")
                        } else {
                            playSound(sound: "jump", type: "mp3")
                        }
                    } label: {
                        Image("dice\(game.player2.diceValue == 0 ? 6:game.player2.diceValue)")
                            .resizable()
                            .modifier(AvatarImageModifier())
                            .opacity(game.player2.isCurrent ? 1 : 0.5 )
                            .animation(.default, value: game.player2.isCurrent)
                    }
                    .disabled(game.player1.isCurrent) 
                    Spacer()
                    
                    //MARK: - PLAYER INFOR
                    VStack{
                        Text(game.player2.name)
                            .fontWeight(.heavy)
                            .font(.custom("Lilita One", size: 20))
                            .padding()
                        Text("score: \(game.player2.score)")
                            .modifier(ScoreModifier())
                    }
                    game.player2.image
                        .resizable()
                        .modifier(AvatarImageModifier())
                }
                
                //MARK: - GAME MAP
                ZStack {
                    switch game.gameLevel {
                    case .easy:
                        //MARK: - GAME MAP - EASY
                        VStack{
                            HStack{
                                VStack{
                                    Image(game.player2.position == -1 ? game.player2.avatar : "none")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .modifier(ShadowModifier())
                                    Image(game.player1.position == -1 ?  game.player1.avatar : "none")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .modifier(ShadowModifier())
                                }
                                
                                HStack (spacing: UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.width/10 : UIScreen.main.bounds.width/20){
                                    ForEach(0...5, id: \.self) { index in
                                        SquareView(index: index)
                                    }
                                }
                            }
                            HStack{
                                Spacer()
                                SquareView(index: 6)
//                                    .padding(.trailing)
//                                    .padding(.trailing)
                            }
                            HStack(spacing: UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.width/10 : UIScreen.main.bounds.width/20){
                                ForEach(7...12, id: \.self) { index in
                                    SquareView(index: 19 - index)
                                }
                            }
                            HStack{
                                SquareView(index: 13)
//                                    .padding(.leading)
//                                    .padding(.leading)
                                Spacer()
                            }
                            HStack(spacing: UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.width/10 : UIScreen.main.bounds.width/20){
                                ForEach(14...19, id: \.self) { index in
                                    SquareView(index: index)
                                }
                            }
                        }
                        .modifier(ShadowModifier())
                        .overlay {
                            if game.isThinking {
                                VStack{
                                    Text("Thinking...")
                                        .foregroundColor(Color("Color-orange"))
                                        .font(.custom("Lilita One", size: 30))
                                    ProgressView()
                                }
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .frame(minWidth: 380, idealWidth: 350, maxWidth: 1000, minHeight: 320, idealHeight: 450, maxHeight: 900, alignment: .center)
                        )
                        .padding()
                        .disabled(true)
                        Spacer()
                        
                    //MARK: - GAME MAP - MEDIUM
                    case .medium:
                        VStack{
                            HStack{
                                VStack{
                                    Image(game.player2.position == -1 ? game.player2.avatar : "none")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .modifier(ShadowModifier())
                                    Image(game.player1.position == -1 ?  game.player1.avatar : "none")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .modifier(ShadowModifier())
                                }
                                
                                HStack(spacing: UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.width/10 : UIScreen.main.bounds.width/20){
                                    ForEach(0...5, id: \.self) { index in
                                        SquareView(index: index)
                                    }
                                }
                            }
                            HStack{
                                Spacer()
                                SquareView(index: 6)
//                                    .padding(.trailing)
//                                    .padding(.trailing)
                            }
                            HStack(spacing: UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.width/10 : UIScreen.main.bounds.width/20){
                                ForEach(7...12, id: \.self) { index in
                                    SquareView(index: 19 - index)
                                }
                            }
                            HStack{
                                SquareView(index: 13)
//                                    .padding(.leading)
//                                    .padding(.leading)
                                Spacer()
                            }
                            HStack(spacing: UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.width/10 : UIScreen.main.bounds.width/20){
                                ForEach(14...19, id: \.self) { index in
                                    SquareView(index: index)
                                }
                            }
                            HStack{
                                Spacer()
                                SquareView(index: 20)
//                                    .padding(.trailing)
//                                    .padding(.trailing)
                            }
                            HStack(spacing: UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.width/10 : UIScreen.main.bounds.width/20){
                                ForEach(21...26, id: \.self) { index in
                                    SquareView(index: 47 - index)
                                }
                            }
                            HStack{
                                SquareView(index: 27)
//                                    .padding(.leading)
//                                    .padding(.leading)
                                Spacer()
                            }
                            HStack(spacing: UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.width/10 : UIScreen.main.bounds.width/20){
                                ForEach(28...33, id: \.self) { index in
                                    SquareView(index: index)
                                }
                            }
                        }
                        .modifier(ShadowModifier())
                        .overlay {
                            if game.isThinking {
                                VStack{
                                    Text("Thinking...")
                                        .foregroundColor(Color("Color-orange"))
                                        .font(.custom("Lilita One", size: 30))
                                    ProgressView()
                                }
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .frame(minWidth: 380, idealWidth: 350, maxWidth: 1000, minHeight: 320, idealHeight: 450, maxHeight: 800, alignment: .center)
                        )
                        .padding()
                        .disabled(true)
                        
                    //MARK: - GAME MAP - HARD
                    case .hard:
                        VStack{
                            HStack{
                                VStack{
                                    Image(game.player2.position == -1 ? game.player2.avatar : "none")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .modifier(ShadowModifier())
                                    Image(game.player1.position == -1 ?  game.player1.avatar : "none")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .modifier(ShadowModifier())
                                }
                                
                                HStack(spacing: UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.width/10 : UIScreen.main.bounds.width/20){
                                    ForEach(0...5, id: \.self) { index in
                                        SquareView(index: index)
                                    }
                                }
                            }
                            HStack{
                                Spacer()
                                SquareView(index: 6)
//                                    .padding(.trailing)
//                                    .padding(.trailing)
                            }
                            HStack(spacing: UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.width/10 : UIScreen.main.bounds.width/20){
                                ForEach(7...12, id: \.self) { index in
                                    SquareView(index: 19 - index)
                                }
                            }
                            HStack{
                                SquareView(index: 13)
//                                    .padding(.leading)
//                                    .padding(.leading)
                                Spacer()
                            }
                            HStack(spacing: UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.width/10 : UIScreen.main.bounds.width/20){
                                ForEach(14...19, id: \.self) { index in
                                    SquareView(index: index)
                                }
                            }
                            HStack{
                                Spacer()
                                SquareView(index: 20)
//                                    .padding(.trailing)
//                                    .padding(.trailing)
                            }
                            HStack(spacing: UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.width/10 : UIScreen.main.bounds.width/20){
                                ForEach(21...26, id: \.self) { index in
                                    SquareView(index: 47 - index)
                                }
                            }
                            HStack{
                                SquareView(index: 27)
//                                    .padding(.leading)
//                                    .padding(.leading)
                                Spacer()
                            }
                            HStack(spacing: UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.width/10 : UIScreen.main.bounds.width/20){
                                ForEach(28...33, id: \.self) { index in
                                    SquareView(index: index)
                                }
                            }
                        }
                        .modifier(ShadowModifier())
                        .overlay {
                            if game.isThinking {
                                VStack{
                                    Text("Thinking...")
                                        .foregroundColor(Color("Color-orange"))
                                        .font(.custom("Lilita One", size: 30))
                                    ProgressView()
                                }
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .frame(minWidth: 380, idealWidth: 350, maxWidth: 1000, minHeight: 320, idealHeight: 450, maxHeight: 800, alignment: .center)
                        )
                        .padding()
                        .disabled(true)
                    }
                }.focused($focus)
                
                //MARK: - PLAYER-1 AREA
                HStack{
                    //MARK: - PLAYER INFOR
                    game.player1.image
                        .resizable()
                        .modifier(AvatarImageModifier())
                    VStack{
                        Text(game.player1.name)
                            .fontWeight(.heavy)
                            .font(.custom("Lilita One", size: 20))
                            .padding()
                        Text("score: \(game.player1.score)")
                            .modifier(ScoreModifier())
                    }
                    
                    Spacer()
                    
                    //MARK: - DICE
                    Button {
                        game.makeMove()
                        playSound(sound: "diceroll", type: "mp3")
                        do{sleep(1)}
                        if game.possibleMoves == false {
                            playSound(sound: "negative", type: "mp3")
                        } else if game.getBomb == true {
                            playSound(sound: "explotion", type: "mp3")
                        } else if game.getPortal == true {
                            playSound(sound: "teleport", type: "mp3")
                        } else if game.isKicked == true {
                            playSound(sound: "aha", type: "mp3")
                        } else {
                            playSound(sound: "jump", type: "mp3")
                        }
                        print(game.showBadge)
                    } label: {
                        Image("dice\(game.player1.diceValue == 0 ? 1:game.player1.diceValue)")
                            .resizable()
                            .modifier(AvatarImageModifier())
                            .opacity(game.player1.isCurrent ? 1 : 0.5)
                            .animation(.default, value: game.player1.isCurrent)
                    }
                    .disabled(game.player2.isCurrent)
                }
            }//Close vstack
            .disabled(game.gameOver)
            
            // MARK: - GAMEOVER MODAL
            if game.gameOver{
                ZStack{
                    Color("Color-black-transparent")
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        Text("game-over")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color("Color-purple"))
                            .padding()
                            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                            .background(Color("Color-red"))
                        
                        Spacer()
                        
                        VStack {
                            Image("logo2")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 150)
                            Text("winner")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                            Text("\(game.player1.isWinner ? game.player1.name : game.player2.name)")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                            Text("see-you")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                            
                            //MARK: - NEW GAME BUTTON
                            Button {
                                game.reset()
                                audioPlayer?.stop()
                            } label: {
                                Text("new-game")
                                    .foregroundColor(Color(.white))
                                    .fontWeight(.medium)
                            }
                            .padding(.vertical,10)
                            .padding(.horizontal, 20)
                            .background(
                                Capsule()
                                    .strokeBorder(lineWidth: 2)
                                    .foregroundColor(Color("Color-red"))
                            )
                            
                            //MARK: - NEXT LEVEL BUTTON
                            if game.gameLevel != .hard {
                                Button {
                                    game.reset()
                                    
                                    game.setupLevel(gameLevel: game.gameLevel == .easy ? .medium : .hard)
                                    audioPlayer?.stop()
                                } label: {
                                    Text("next-level")
                                        .foregroundColor(Color(.white))
                                        .fontWeight(.medium)
                                }
                                .padding(.vertical,10)
                                .padding(.horizontal, 20)
                                .background(
                                    Capsule()
                                        .strokeBorder(lineWidth: 2)
                                        .foregroundColor(Color("Color-red"))
                                )
                            }
                        }
                        Spacer()
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 280, idealHeight: 300, maxHeight: 350, alignment: .center)
                    .background(Color("Color-purple"))
                    .cornerRadius(20)
                }.onAppear(perform: {
                    playSound(sound: "drum-music", type: "mp3")
                })
            }
                
        }//Close zstack
//        .alert("You get starter badge", isPresented: $game.showBadge) {
//            Button("OK", role: .cancel) {game.showBadge = false}
//        }
        .environment(\.colorScheme, game.isDark ? .dark : .light)
        
        //MARK: - GAME EXIT BUTTON
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    dismiss()
                    playSound(sound: "fairytail", type: "mp3")
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                }
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.trailing, 10)
            }
        }
        //MARK: - GAME SAVING BUTTON
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    game.saveProgress()
                    playSound(sound: "bonus", type: "mp3")
                }) {
                    Image(systemName: "square.and.arrow.down")
                        .font(.title)
                }
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.trailing, 10)
            }
        }
        //MARK: - GAME RESET BUTTON
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    game.reset()
                    playSound(sound: "twink", type: "mp3")
                }) {
                    Image(systemName: "arrow.2.circlepath.circle")
                        .font(.title)
                }
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.trailing, 10)
            }
        }
        .inNavigationStack()
    }
}

//MARK: - GAME PREVIEW
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameService())
    }
}

//MARK: - PLAYER BUTTON STYLE
struct PlayerBtnStyle: ButtonStyle {
    let isCurrent: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(isCurrent ? Color.green : Color.gray)
            )
            .foregroundColor(.white)
    }
}
