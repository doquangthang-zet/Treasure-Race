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

struct MenuView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var game: GameService
    @State private var continue_status: Bool = false
    @State private var start: Bool = false
    @State private var leaderBoard: Bool = false
    @State private var howToPlay: Bool = false
    @State private var setting: Bool = false
    
    //MARK: - BODY
    var body: some View {
        ZStack{
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("Color-orange"), Color("Color-red")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                // MARK: - LOGO HEADER
                LogoView(logoFileName: "logo2")
                
                //MARK: - CONTINUE BUTTON
                Spacer()
                if game.progress {
                    Button {
                        game.restore()
                        continue_status = true
                        audioPlayer?.stop()
                    } label: {
                        Text("continue")
                            .modifier(ButtonMenuModifier())
                    }
                    .modifier(LightShadowModifier())
                }
                
                //MARK: - OTHER BUTTONS
                Button {
                    start = true
                } label: {
                    Text("start-button")
                        .modifier(ButtonMenuModifier())
                }
                .modifier(LightShadowModifier())
                
                Button {
                    leaderBoard = true
                } label: {
                    Text("leader-board")
                        .modifier(ButtonMenuModifier())
                }
                .modifier(LightShadowModifier())
                
                Button {
                    howToPlay = true
                } label: {
                    Text("how-to-play")
                        .modifier(ButtonMenuModifier())
                }
                .modifier(LightShadowModifier())
                
                Button {
                    setting = true
                } label: {
                    Text("settings")
                        .modifier(ButtonMenuModifier())
                }
                .modifier(LightShadowModifier())
                
                Spacer()
            } 
        }//zstack
        .environment(\.colorScheme, game.isDark ? .dark : .light)
        .onAppear {
            playSound(sound: "fairytail", type: "mp3")
            game.getUsers()
        }
        .onDisappear {
            audioPlayer?.stop()
        }
        .fullScreenCover(isPresented: $start){
            GameTypeView()
                .environment(\.locale, Locale.init(identifier: game.language))
        }
        .fullScreenCover(isPresented: $leaderBoard){
            LeaderBoardView()
                .environment(\.locale, Locale.init(identifier: game.language))
        }
        .fullScreenCover(isPresented: $howToPlay){
            HowToPlayView()
                .environment(\.locale, Locale.init(identifier: game.language))
        }
        .fullScreenCover(isPresented: $setting){
            SettingView()
                .environment(\.locale, Locale.init(identifier: game.language))
        }
        .fullScreenCover(isPresented: $continue_status){
            GameView()
                .environment(\.locale, Locale.init(identifier: game.language))
        }
        .inNavigationStack()
    }
//    init() {
//        for familyName in UIFont.familyNames {
//            print(familyName)
//
//            for fontName in UIFont.fontNames(forFamilyName: familyName) {
//                print("-- \(fontName)")
//            }
//        }
//    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(GameService())
    }
}
