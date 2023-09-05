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

struct HowToPlayView: View {
    //MARK: - PROPERTIES PART
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var game: GameService
    
    var body: some View {
        ZStack{
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("Color-orange"), Color("Color-red")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack {
                    VStack{
                        Text("how-to-play")
                            .font(game.language == "vi" ? .largeTitle : .custom("LilitaOne", size: 40))
                            .foregroundColor(Color("Color-purple"))
                            .padding()
                    }
                    VStack{
                        Text("way-to-play-1")
                        Text("way-to-play-2")
                        Image("gameview")
                        Text("way-to-play-3")
                        Image("chooseFirst")
                        Text("way-to-play-4")
                        Image("playerbox1")
                        Image("playerbox2")
                        Text("way-to-play-5")
                        
                    }
                    VStack{
                        HStack{
                            Image("dice1")
                            Image("dice6")
                        }
                        Text("way-to-play-6")
                        Image("gamemap")
                        Text("way-to-play-7")
                        Text("way-to-play-8")
                    }
                    VStack{
                        Text("way-to-play-9")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image("bomb")
                        Text("way-to-play-10")
                        Text("way-to-play-11")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image("portal")
                        Text("way-to-play-12")
                    }
                    VStack{
                        Text("way-to-play-13")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image("three")
                        Text("way-to-play-14")
                        Text("way-to-play-15")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image("number")
                        Text("way-to-play-16")
                        Text("way-to-play-17")
                    }
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
