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

//MARK: - GAME ITEMS MODEL
struct GameItems {
    var id: Int
    var player: Player?
    var icons = ["start-button","none","bomb","none","none","three","none","none","none","number","portal","none","none","portal2","none","none","bomb","none","none","treasure"]
    var iconsMedium = ["start-button","none","bomb","none","none","three","none","none","none","number","portal","none","none","portal2","none","none","bomb","none","none","bomb","none","bomb","none","none","none","none","bomb","none","none","none","none","none","none","treasure"]
    var iconsHard = ["start-button","none","bomb","none","none","three","none","none","none","number","portal","none","none","portal2","none","none","bomb","none","none","bomb","none","bomb","none","none","none","none","bomb","none","none","number","none","bomb","bomb","treasure"]
    
    static var level = GameLevel.easy
    
    var image: Image {
        if let player = player {
            return player.image
        } else {
            switch GameItems.level {
            case .easy:
                return Image(icons[id])
            case .medium:
                return Image(iconsMedium[id])
            case .hard:
                return Image(iconsHard[id])
            }
        }
    }
    
    //MARK: - RESET ITEMS ON GAME MAP
    static var reset: [GameItems] {
        var items = [GameItems]()
        switch GameItems.level {
            case .easy:
                for index in 0...19 {
                    items.append(GameItems(id: index))
                }
                return items
            case .medium:
                for index in 0...33 {
                    items.append(GameItems(id: index))
                }
                return items
            case .hard:
                for index in 0...33 {
                    items.append(GameItems(id: index))
                }
                return items
            }
    }
    
    static var resetMedium: [GameItems] {
        var items = [GameItems]()
        for index in 0...33 {
            items.append(GameItems(id: index))
        }
        return items
    }
    
    static var resetHard: [GameItems] {
        var items = [GameItems]()
        for index in 0...33 {
            items.append(GameItems(id: index))
        }
        return items
    }
}
