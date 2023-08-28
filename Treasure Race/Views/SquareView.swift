//
//  SquareView.swift
//  tiktactoe
//
//  Created by Thang Do Quang on 26/08/2023.
//

import SwiftUI

struct SquareView: View {
    @EnvironmentObject var game: GameService
    let index: Int
    var body: some View {
        ZStack{
            game.gameBoard[index].image
                .resizable()
                .modifier(BlockModifier())
            game.gameItems[index].image
                .resizable()
                .frame(width: 30, height: 30)
                .modifier(ShadowModifier())
        }
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(index: 0)
            .environmentObject(GameService())
    }
}
