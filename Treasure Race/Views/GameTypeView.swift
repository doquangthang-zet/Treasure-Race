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

struct GameTypeView: View {
    //MARK: - PROPERTIES PART
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
            
            //MARK: - SELECT GAME TYPE PART
            VStack {
                Picker("Select Game", selection: $gameType) {
                    Text("choose-game-type").tag(GameType.undetermined)
                    Text("play-with-machine").tag(GameType.bot)
                    Text("share-your-device").tag(GameType.single)
                }
                .modifier(ButtonMenuModifier())
                
                //MARK: - GAME TYPE DESCRIPTION
                if gameType.description == "share-des" {
                    Text("share-des")
                        .padding()
                } else if gameType.description == "machine-des" {
                    Text("machine-des")
                        .padding()
                }
                
                VStack{
                    switch gameType {
                    //MARK: - SINGLE PLAYER ELEMENTS
                    case .single:
                        //MARK: - NAME FIELDS
                        VStack{
                            TextField("your-name", text: $yourName)
                                .modifier(ShadowModifier())
                            TextField("opponent-name", text: $opponentName)
                                .modifier(ShadowModifier())
                            
                            //MARK: - AVATAR FIELDS
                            Text("choose-your-character")
                            
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
                            
                            Text("choose-opponent-character")
                            
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
                        
                    //MARK: - BOT ELEMENTS
                    case .bot:
                        TextField("your-name", text: $yourName)
                            .modifier(ShadowModifier())
                        
                        Text("choose-your-character")
                        
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
                        
                    //MARK: - NONE GAME TYPE
                    case .undetermined:
                        EmptyView()
                    }
                }
                .padding()
                .textFieldStyle(.roundedBorder)
                .focused($focus)
                .frame(width: 350)

                //MARK: - START BUTTON
                Button(action: {
                    game.setupGame(gameType: gameType, player1Name: yourName, player2Name: opponentName, player1Avatar: yourAvatar, player2Avatar: opponentAvatar)
                    game.setupLevel(gameLevel: game.gameLevel)
//                    game.reset()
                    focus = false
                    game.progress = false
                    startGame = true
                    audioPlayer?.stop()
                }, label: {
                    Text("start-game")
                        .modifier(ButtonMenuModifier())
                })
                .modifier(LightShadowModifier())
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
