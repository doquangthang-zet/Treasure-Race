//
//  SettingView.swift
//  Treasure Race
//
//  Created by Thang Do Quang on 27/08/2023.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var game: GameService
    @State private var level: GameLevel = .easy
    
    
    var body: some View {
        ZStack{
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("Color-orange"), Color("Color-red")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
     
            VStack{
                Text("Ajust difficulty")
                    .modifier(ButtonMenuModifier())
                    
                Picker("Select Game Level", selection: $game.gameLevel) {
                    Text("Easy").tag(GameLevel.easy)
                    Text("Medium").tag(GameLevel.medium)
                    Text("Hard").tag(GameLevel.hard)
                }
                .modifier(ScoreModifier())
                .padding()

                Text(level.description)
                    .padding(.bottom, 20)
                    .font(.custom("LilitaOne", size: 20))
                    .foregroundColor(Color("Color-purple"))
                

                Text("Theme")
                    .modifier(ButtonMenuModifier())
                
                Button(action: {game.isDark.toggle()}, label: {
                    game.isDark ? Label("Dark", systemImage: "moon.circle.fill"):Label("Light", systemImage: "moon.circle")
                })
                
                .padding()
                
                Text("Ajust language")
                    .modifier(ButtonMenuModifier())
                Picker("Select Game Level", selection: $game.language) {
                    Text("English").tag("en")
                    Text("Vietnamese").tag("vi")
                }
                .modifier(ScoreModifier())
                .padding()
            }
        }
        .environment(\.colorScheme, game.isDark ? .dark : .light)
//        .onAppear {
//            audioPlayer?.stop()
//        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
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

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(GameService())
    }
}
