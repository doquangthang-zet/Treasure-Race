//
//  MenuView.swift
//  Treasure Race
//
//  Created by Thang Do Quang on 25/08/2023.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var game: GameService
    @State private var start: Bool = false
    @State private var leaderBoard: Bool = false
    @State private var howToPlay: Bool = false
    @State private var setting: Bool = false
    
    var body: some View {
        ZStack{
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("Color-orange"), Color("Color-red")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                // MARK: - LOGO HEADER
                LogoView(logoFileName: "logo2")
                
                Spacer()
                Button {
                    start = true
                } label: {
                    Text("start")
                        .modifier(ButtonMenuModifier())
                }
                .modifier(LightShadowModifier())
                
                Button {
                    leaderBoard = true
                } label: {
                    Text("leader_board")
                        .modifier(ButtonMenuModifier())
                }
                .modifier(LightShadowModifier())
                Button {
                    howToPlay = true
                } label: {
                    Text("how_to_play")
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
