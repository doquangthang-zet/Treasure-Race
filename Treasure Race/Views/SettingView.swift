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
                Picker("Select Game Level", selection: $level) {
                    Text("Easy").tag(GameLevel.easy)
                    Text("Medium").tag(GameLevel.medium)
                    Text("Hard").tag(GameLevel.hard)
                }
                .modifier(ScoreModifier())
                .padding()

                Button {
                    game.setupLevel(gameLevel: level)
                } label: {
                    Text("Set")
                        .modifier(LevelButtonModifier())
                }
                .modifier(LightShadowModifier())
            }
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

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(GameService())
    }
}
