//
//  HowToPlayView.swift
//  Treasure Race
//
//  Created by Thang Do Quang on 27/08/2023.
//

import SwiftUI

struct HowToPlayView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var game: GameService
    
    var body: some View {
        ZStack{
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("Color-orange"), Color("Color-red")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack {
                    Text("How To Play")
                        .font(.custom("LilitaOne", size: 40))
                        .foregroundColor(Color("Color-purple"))
                        .padding()
                    Text("\tThis is a simple dice game in which two players try to outrun each other to reach the treasure first.\n\tTo start the game, players need to enter their name, select an avatar and select the game type. The game supports 2 different game types, in which players can play against the computer or share the device with another player.\nBelow is the main interface of the game:\nFirst, the user needs to decide who goes first by choosing one of the two buttons with the player's name at the top of the screen.\nBelow we can see the status bars of players 1 and 2 as follows:\nThe status bar includes each player's name, avatar, score and dice. When it's their turn, the player will click on the dice icon to roll, the results returned corresponding to the number of steps that the player will make.\nThis area shows treasure maps and milestones, where the first square is the starting point. When the player has not entered the starting square, they need to roll the dice with a result of 1 or 6 to advance to the starting square. After that, the player will be given another turn.\nThe game ends when one of the two players reaches the final point with the treasure icon.\nAlong the way, there are a few obstacles that players must pay attention to. The first is the 💣 icon, when entering this icon, the player will be killed and kicked out of the track. With the portal icon, the player will be moved to a different cell with that icon. The 'plus 3' icon allows the player to advance 3 cells, and the 'minus 2' icon makes the player move 2 cells back.\n Additionally, the game allows players to overtake their opponents, however, if a player encounters their opponent on the same square, they can kick them off the track.")
                }
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

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
            .environmentObject(GameService())
    }
}
