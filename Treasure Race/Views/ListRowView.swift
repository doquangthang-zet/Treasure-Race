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

struct ListRowView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var game: GameService
    @Environment(\.dismiss) var dismiss
    let u: Player
    
    //MARK: - START LIST ROW VIEW UI
    var body: some View {
        HStack{
            u.image
                .resizable()
                .frame(width: 50, height: 50)

            Text(u.name)
            
            Text("score: \(u.score)")
            Spacer()
            
            //MARK: - PLAYER BADGES
            Image(u.getBadge1 ? "bronze-medal" : "none")
                .resizable()
                .modifier(IconsModifier())
            
            Image(u.getBadge2 ? "silver-medal" : "none")
                .resizable()
                .modifier(IconsModifier())
            
            Image(u.getBadge3 ? "gold-medal" : "none")
                .resizable()
                .modifier(IconsModifier())
        }
//        .listRowBackground(Color.green)
    }
}

//MARK: - PREVIEW
struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(u: Player(avatar: "magician", name: "Princess"))
            .environmentObject(GameService())
    }
}
