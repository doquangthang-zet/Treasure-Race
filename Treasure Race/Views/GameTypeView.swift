//
//  GameTypeView.swift
//  Treasure Race
//
//  Created by Thang Do Quang on 26/08/2023.
//

import SwiftUI

struct GameTypeView: View {
    @EnvironmentObject var game: GameService
    @Environment(\.dismiss) var dismiss
    @State private var gameType: GameType = .undetermined
    @State private var yourName: String = ""
    @State private var opponentName: String = ""
    @State private var yourAvatar: String = ""
    @State private var opponentAvatar: String = ""
    @FocusState private var focus: Bool
    @State private var startGame: Bool = false
    @State private var level: GameLevel = .easy
    
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("Color-orange"), Color("Color-red")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Picker("Select Game", selection: $gameType) {
                    Text("Choose game type").tag(GameType.undetermined)
                    Text("Play with machine").tag(GameType.bot)
                    Text("Share your device").tag(GameType.single)
                }
                .modifier(ButtonMenuModifier())
                
                Text(gameType.description)
                    .padding()
                
                VStack{
                    switch gameType {
                    case .single:
                        VStack{
                            TextField("Your name", text: $yourName)
                                .modifier(ShadowModifier())
                            TextField("Opponent name", text: $opponentName)
                                .modifier(ShadowModifier())
                            
                            Text("Choose your avatar")
                            
                            HStack{
                                Button {
                                    yourAvatar = "pirate"
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(Color(.white))
                                            .modifier(ShadowModifier())
                                        
                                        Image("pirate")
                                            .resizable()
                                            .modifier(AvatarImageModifier())
                                    }
                                    .opacity(yourAvatar == "pirate" ? 0.5 : 1)
                                }
                                .disabled(opponentAvatar == "pirate")
                                Button {
                                    yourAvatar = "knight"
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(Color(.white))
                                            .modifier(ShadowModifier())
                                        
                                        Image("knight")
                                            .resizable()
                                            .modifier(AvatarImageModifier())
                                    }
                                    .opacity(yourAvatar == "knight" ? 0.5 : 1)
                                }
                                .disabled(opponentAvatar == "knight")
                                Button {
                                    yourAvatar = "magician"
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(Color(.white))
                                            .modifier(ShadowModifier())
                                        Image("magician")
                                            .resizable()
                                            .modifier(AvatarImageModifier())
                                    }
                                    .opacity(yourAvatar == "magician" ? 0.5 : 1)
                                }
                                .disabled(opponentAvatar == "magician")
                            }
                            
                            Text("Choose opponent avatar")
                            
                            HStack{
                                Button {
                                    opponentAvatar = "pirate"
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(Color(.white))
                                            .modifier(ShadowModifier())
                                        
                                        Image("pirate")
                                            .resizable()
                                            .modifier(AvatarImageModifier())
                                    }
                                    .opacity(opponentAvatar == "pirate" ? 0.5 : 1)
                                }
                                .disabled(yourAvatar == "pirate")
                                Button {
                                    opponentAvatar = "knight"
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(Color(.white))
                                            .modifier(ShadowModifier())
                                        
                                        Image("knight")
                                            .resizable()
                                            .modifier(AvatarImageModifier())
                                    }
                                    .opacity(opponentAvatar == "knight" ? 0.5 : 1)
                                }
                                .disabled(yourAvatar == "knight")
                                Button {
                                    opponentAvatar = "magician"
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(Color(.white))
                                            .modifier(ShadowModifier())
                                        Image("magician")
                                            .resizable()
                                            .modifier(AvatarImageModifier())
                                    }
                                    .opacity(opponentAvatar == "magician" ? 0.5 : 1)
                                }
                                .disabled(yourAvatar == "magician")
                            }
                        }
                    case .bot:
                        TextField("Your name", text: $yourName)
                            .modifier(ShadowModifier())
                        
                        Text("Choose your avatar")
                        
                        HStack{
                            Button {
                                yourAvatar = "pirate"
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(Color(.white))
                                        .modifier(ShadowModifier())
                                    
                                    Image("pirate")
                                        .resizable()
                                        .modifier(AvatarImageModifier())
                                }
                                .opacity(yourAvatar == "pirate" ? 0.5 : 1)
                            }
                            Button {
                                yourAvatar = "knight"
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(Color(.white))
                                        .modifier(ShadowModifier())
                                    
                                    Image("knight")
                                        .resizable()
                                        .modifier(AvatarImageModifier())
                                }
                                .opacity(yourAvatar == "knight" ? 0.5 : 1)
                            }
                            Button {
                                yourAvatar = "magician"
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(Color(.white))
                                        .modifier(ShadowModifier())
                                    Image("magician")
                                        .resizable()
                                        .modifier(AvatarImageModifier())
                                }
                                .opacity(yourAvatar == "magician" ? 0.5 : 1)
                            }
                        }
                    case .undetermined:
                        EmptyView()
                    }
                }
                .padding()
                .textFieldStyle(.roundedBorder)
                .focused($focus)
                .frame(width: 350)
                
//                Text("Choose Difficulty")
//
//                Picker("Select Game Level", selection: $level) {
//                    Text("Easy").tag(GameLevel.easy)
//                    Text("Medium").tag(GameLevel.medium)
//                    Text("Hard").tag(GameLevel.hard)
//                }
//                .modifier(LevelButtonModifier())
//
//                Text(level.description)
//                    .padding()

                Button(action: {
                    game.setupGame(gameType: gameType, player1Name: yourName, player2Name: opponentName, player1Avatar: yourAvatar, player2Avatar: opponentAvatar)
                    game.setupLevel(gameLevel: game.gameLevel)
                    focus = false
                    startGame = true
                    audioPlayer?.stop()
                }, label: {
                    Text("Start Game")
                        .modifier(ButtonMenuModifier())
                })
                .disabled(
                    gameType == .undetermined ||
                    gameType == .bot && (yourName.isEmpty || yourAvatar.isEmpty) ||
                    gameType == .single && (yourName.isEmpty || opponentName.isEmpty || yourAvatar.isEmpty || opponentAvatar.isEmpty)
                )
                Spacer()
            }
        }
        .environment(\.colorScheme, game.isDark ? .dark : .light)
        .fullScreenCover(isPresented: $startGame){
            GameView()
                .environment(\.locale, Locale.init(identifier: game.language))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    //audioPlayer?.stop()
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                }
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.trailing, 10)
                
//                .onAppear(perform: {
//                    playSound(sound: "drum-music", type: "mp3")
//                }
            }
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
