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

//MARK: - GAME TYPE MODEL
enum GameType: String, Codable, CaseIterable {
    case single, bot, undetermined
    
    var description: String {
        switch self {
        case .single:
            return "share-des";
        case .bot:
            return "machine-des";
        case .undetermined:
            return ""
        }
    }
}

//MARK: - GAME LEVEL MODEL
enum GameLevel: String, Codable, CaseIterable {
    case easy, medium, hard
    
    var description: String {
        switch self {
        case .easy:
            return "easy-des";
        case .medium:
            return "medium-des";
        case .hard:
            return "hard-des"
        }
    }
}

//MARK: - PLAYER MODEL
struct Player: Identifiable, Codable {
    let id: String
    var avatar: String
    var name: String
    var position: Int = -1
    var diceValue: Int = 0
    var score: Int = 0
    var isCurrent = false
    var onRoad = false
    var isWinner:Bool = false
    var getBadge1:Bool = false
    var getBadge2:Bool = false
    var getBadge3:Bool = false
    
    var image: Image {
        Image(self.avatar)
    }
    
    func rollDice() {
        Dice.current = Int.random(in: 1...6)
    }
    
//    func kick(p: Player) {
//        var player = p
//        player.position = -1
//        player.onRoad = false
//    }
    init(id: String = UUID().uuidString, avatar: String, name: String) {
        self.id = id
        self.avatar = avatar
        self.name = name
    }
}

//MARK: - DICE MODEL
enum Dice{
    static var all = [1,2,3,4,5,6]
    
    static var current = 0
}

//MARK: - NODE MODEL
enum Move{
    static var winningMove = 19
    static var winningMoveMedium = 33
    static var winningMoveHard = 33
    static var startPoint = 0
}
