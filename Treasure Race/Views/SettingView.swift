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

struct SettingView: View {
    //MARK: - PROPERTIES
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var game: GameService
    @State private var level: GameLevel = .easy
    
    var body: some View {
        ZStack{
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("Color-orange"), Color("Color-red")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
     
            //MARK: - DIFFICULTY PART
            VStack{
                Text("choose-difficulty")
                    .font(game.language == "vi" ? .largeTitle : .custom("LilitaOne", size: 40))
                    .foregroundColor(Color("Color-purple"))
                    
                Picker("Select Game Level", selection: Binding(    // proxy binding
                    get: { self.level },     // get value from storage
                    set: {
                            self.level = $0  // set value to storage

                        self.game.setupLevel(gameLevel: level) // didSet function
                    })) {
                    Text("easy").tag(GameLevel.easy)
                    Text("medium").tag(GameLevel.medium)
                    Text("hard").tag(GameLevel.hard)
                }
                .modifier(ScoreModifier())

                //MARK: - DIFFICULTY DESCRIPTION
                if level.description == "easy-des" {
                    Text("easy-des")
                        .padding(.bottom, 20)
                        .font(game.language == "vi" ? .largeTitle : .custom("LilitaOne", size: 20))
                        .foregroundColor(Color("Color-purple"))
                } else if level.description == "medium-des" {
                    Text("medium-des")
                        .padding(.bottom, 20)
                        .font(game.language == "vi" ? .largeTitle : .custom("LilitaOne", size: 20))
                        .foregroundColor(Color("Color-purple"))
                } else {
                    Text("hard-des")
                        .padding(.bottom, 20)
                        .font(game.language == "vi" ? .largeTitle : .custom("LilitaOne", size: 20))
                        .foregroundColor(Color("Color-purple"))
                }

                //MARK: - THEME PART
                Text("change-theme")
                    .font(game.language == "vi" ? .largeTitle : .custom("LilitaOne", size: 40))
                    .foregroundColor(Color("Color-purple"))
                
                Button(action: {game.isDark.toggle()}, label: {
                    game.isDark ? Label("dark", systemImage: "moon.circle.fill"):Label("light", systemImage: "moon.circle")
                })
                .padding(.bottom, 20)
                
                //MARK: - LANGUAGE PART
                Text("choose-language")
                    .font(game.language == "vi" ? .largeTitle : .custom("LilitaOne", size: 40))
                    .foregroundColor(Color("Color-purple"))
                Picker("Select Game Level", selection: $game.language) {
                    Text("English").tag("en")
                    Text("Vietnamese").tag("vi")
                }
                .modifier(ScoreModifier())
                .padding(.bottom, 20)
            }
        }
        .environment(\.colorScheme, game.isDark ? .dark : .light)
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
