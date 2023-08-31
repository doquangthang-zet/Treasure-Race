//
//  LeaderBoardView.swift
//  Treasure Race
//
//  Created by Thang Do Quang on 27/08/2023.
//

import SwiftUI

struct LeaderBoardView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var game: GameService
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("Color-orange"), Color("Color-red")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
            }
        }
        .environment(\.colorScheme, game.isDark ? .dark : .light)
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

struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView()
            .environmentObject(GameService())
    }
}
