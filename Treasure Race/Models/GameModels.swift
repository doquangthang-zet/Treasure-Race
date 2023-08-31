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

enum GameLevel {
    case easy, medium, hard
    
    var description: String {
        switch self {
        case .easy:
            return "The road is short and a little obstacles";
        case .medium:
            return "Longer road";
        case .hard:
            return "Longer road and more obstacles"
        }
    }
}

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
    
    func kick(p: Player) {
        var player = p
        player.position = -1
        player.onRoad = false
    }
    init(id: String = UUID().uuidString, avatar: String, name: String) {
        self.id = id
        self.avatar = avatar
        self.name = name
    }
}

enum Dice{
    static var all = [1,2,3,4,5,6]
    
    static var current = 0
}

enum Move{
    static var winningMove = 19
    static var winningMoveMedium = 33
    static var winningMoveHard = 33
    static var startPoint = 0
}
