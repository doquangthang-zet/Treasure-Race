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

struct LeaderBoardView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var game: GameService
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("Color-orange"), Color("Color-red")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            List{
                HStack{
                    Spacer()
                    Text("leader-board")
                        .font(game.language == "vi" ? .largeTitle : .custom("LilitaOne", size: 40))
                        .foregroundColor(Color("Color-purple"))
                    Spacer()
                }
                
                ForEach(game.users) { user in
                    ListRowView(u: user)
                }
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color("Color-orange"), Color("Color-red")]), startPoint: .top, endPoint: .bottom))
            .scrollContentBackground(.hidden)
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

struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView()
            .environmentObject(GameService())
    }
}
