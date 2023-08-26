//
//  GameSquare.swift
//  tiktactoe
//
//  Created by Thang Do Quang on 26/08/2023.
//

import SwiftUI

struct GameSquare {
    var id: Int
    var player: Player?
    
    var image: Image {
        if let player = player {
            return player.gamePiece.image
        } else {
            return Image("frame_black")
        }
    }
    
    static var reset: [GameSquare] {
        var squares = [GameSquare]()
        for index in 1...20 {
            squares.append(GameSquare(id: index))
        }
        return squares
    }
}
