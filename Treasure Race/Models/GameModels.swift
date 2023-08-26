//
//  GameModels.swift
//  tiktactoe
//
//  Created by Thang Do Quang on 26/08/2023.
//

import SwiftUI

enum GameType {
    case single, bot, undetermined
    
    var description: String {
        switch self {
        case .single:
            return "Share your iphone with your friend";
        case .bot:
            return "Play with your iphone";
        case .undetermined:
            return ""
        }
    }
}

enum GamePiece: String {
    case bomb, portal,heart,shield, knight, pirate
    var image: Image {
        Image(self.rawValue)
    }
}

struct Player {
    let gamePiece: GamePiece
    var name: String
    var position: Int = 0
    var isCurrent = false
    var isWinner:Bool {
        if position == Move.winningMove {
            return true
        }
        return false
    }
}

enum Move{
    static var all = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    
    static var winningMove = 20
}
