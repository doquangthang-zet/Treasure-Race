////
////  ListRowView.swift
////  Treasure Race
////
////  Created by Thang Do Quang on 31/08/2023.
////
//
import SwiftUI

struct ListRowView: View {
    @EnvironmentObject var game: GameService
    @Environment(\.dismiss) var dismiss
    let u: Player
    var body: some View {
        HStack{
            u.image
                .resizable()
                .frame(width: 50, height: 50)

            Text(u.name)
            
            Text("Score: \(u.score)")
            Spacer()
            
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
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(u: Player(avatar: "magician", name: "Princess"))
            .environmentObject(GameService())
    }
}
