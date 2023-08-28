//
//  GameView.swift
//  Treasure Race
//
//  Created by Thang Do Quang on 25/08/2023.
//

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
                        Text("Select a player to start")
                    }
                    HStack{
                        Button(game.player1.name) {
                            game.player1.isCurrent = true
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
                    Button {
                        game.makeMove()
                    } label: {
                        Image("dice\(game.player2.diceValue == 0 ? 6:game.player2.diceValue)")
                            .resizable()
                            .modifier(AvatarImageModifier())
                            .opacity(game.player2.isCurrent ? 1 : 0.5 )
                            .animation(.default, value: game.player2.isCurrent)
                    }
                    .disabled(game.player1.isCurrent) 
                    Spacer()
                    VStack{
                        Text(game.player2.name)
                            .fontWeight(.heavy)
                            .font(.custom("Lilita One", size: 20))
                            .padding()
                        Text("Score: \(game.player2.score)")
                            .modifier(ScoreModifier())
                    }
                    game.player2.image
                        .resizable()
                        .modifier(AvatarImageModifier())
                }
                
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
                                
                                HStack{
                                    ForEach(0...5, id: \.self) { index in
                                        SquareView(index: index)
                                    }
                                }
                            }
                            HStack{
                                Spacer()
                                SquareView(index: 6)
                                    .padding(.trailing)
                                    .padding(.trailing)
                            }
                            HStack{
                                ForEach(7...12, id: \.self) { index in
                                    SquareView(index: 19 - index)
                                }
                            }
                            HStack{
                                SquareView(index: 13)
                                    .padding(.leading)
                                    .padding(.leading)
                                Spacer()
                            }
                            HStack{
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
                            Image("bgmap")
                                .resizable()
                                .frame(width: 400, height: 300)
                        )
                        .disabled(true)
                        Spacer()
                    case .medium:
                        //MARK: - GAME MAP - MEDIUM
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
                                
                                HStack{
                                    ForEach(0...5, id: \.self) { index in
                                        SquareView(index: index)
                                    }
                                }
                            }
                            HStack{
                                Spacer()
                                SquareView(index: 6)
                                    .padding(.trailing)
                                    .padding(.trailing)
                            }
                            HStack{
                                ForEach(7...12, id: \.self) { index in
                                    SquareView(index: 19 - index)
                                }
                            }
                            HStack{
                                SquareView(index: 13)
                                    .padding(.leading)
                                    .padding(.leading)
                                Spacer()
                            }
                            HStack{
                                ForEach(14...19, id: \.self) { index in
                                    SquareView(index: index)
                                }
                            }
                            HStack{
                                Spacer()
                                SquareView(index: 20)
                                    .padding(.trailing)
                                    .padding(.trailing)
                            }
                            HStack{
                                ForEach(21...26, id: \.self) { index in
                                    SquareView(index: 47 - index)
                                }
                            }
                            HStack{
                                SquareView(index: 27)
                                    .padding(.leading)
                                    .padding(.leading)
                                Spacer()
                            }
                            HStack{
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
                                .frame(width: 350, height: 450)
                        )
                        .padding()
                        .disabled(true)
                        
                    case .hard:
                        //MARK: - GAME MAP - HARD
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
                                
                                HStack{
                                    ForEach(0...5, id: \.self) { index in
                                        SquareView(index: index)
                                    }
                                }
                            }
                            HStack{
                                Spacer()
                                SquareView(index: 6)
                                    .padding(.trailing)
                                    .padding(.trailing)
                            }
                            HStack{
                                ForEach(7...12, id: \.self) { index in
                                    SquareView(index: 19 - index)
                                }
                            }
                            HStack{
                                SquareView(index: 13)
                                    .padding(.leading)
                                    .padding(.leading)
                                Spacer()
                            }
                            HStack{
                                ForEach(14...19, id: \.self) { index in
                                    SquareView(index: index)
                                }
                            }
                            HStack{
                                Spacer()
                                SquareView(index: 20)
                                    .padding(.trailing)
                                    .padding(.trailing)
                            }
                            HStack{
                                ForEach(21...26, id: \.self) { index in
                                    SquareView(index: 47 - index)
                                }
                            }
                            HStack{
                                SquareView(index: 27)
                                    .padding(.leading)
                                    .padding(.leading)
                                Spacer()
                            }
                            HStack{
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
                                .frame(width: 350, height: 450)
                        )
                        .padding()
                        .disabled(true)
                    }
                }.focused($focus)
                //MARK: - PLAYER-1 AREA
                HStack{
                    game.player1.image
                        .resizable()
                        .modifier(AvatarImageModifier())
                    VStack{
                        Text(game.player1.name)
                            .fontWeight(.heavy)
                            .font(.custom("Lilita One", size: 20))
                            .padding()
                        Text("Score: \(game.player1.score)")
                            .modifier(ScoreModifier())
                    }
                    
                    Spacer()
                    Button {
                        game.makeMove()
                        print(game.player2.position)
                        print(game.player1.position)
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
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                            .background(Color("Color-red"))
                        
                        Spacer()
                        
                        VStack {
                            Image("logo2")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 150)
                            Text("The winner is\n\(game.player1.isWinner ? game.player1.name : game.player2.name)\n See you again!")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                            Button {
                                game.reset()
                                audioPlayer?.stop()
                            } label: {
                                Text("New Game".uppercased())
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    audioPlayer?.stop()
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle")
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
