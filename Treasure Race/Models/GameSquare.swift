//
//  GameSquare.swift
//  tiktactoe
//
//  Created by Thang Do Quang on 26/08/2023.
//

import SwiftUI

struct GameSquare {
    var id: Int
    
    var image: Image {
        return Image("frame_black")
    }
    
    static var reset: [GameSquare] {
        var squares = [GameSquare]()
        for index in 0...19 {
            squares.append(GameSquare(id: index))
        }
        return squares
    }
    static var resetMedium: [GameSquare] {
        var squares = [GameSquare]()
        for index in 0...33 {
            squares.append(GameSquare(id: index))
        }
        return squares
    }
}
