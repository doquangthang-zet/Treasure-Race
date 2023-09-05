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

//MARK: - GAME SQUARE MODEL
struct GameSquare {
    var id: Int
    
    var image: Image {
        return Image("frame_black")
    }
    
    //MARK: - RESET SQUARE ON MAP
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
