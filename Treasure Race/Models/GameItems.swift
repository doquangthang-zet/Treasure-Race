//
//  GameItems.swift
//  Treasure Race
//
//  Created by Thang Do Quang on 27/08/2023.
//

import SwiftUI

struct GameItems {
    var id: Int
    var player: Player?
    var icons = ["start-button","none","bomb","none","none","three","none","none","none","number","portal","none","none","portal2","none","none","bomb","none","none","treasure"]
    var iconsMedium = ["start-button","none","bomb","none","none","three","none","none","none","number","portal","none","none","portal2","none","none","bomb","none","none","none","none","bomb","none","none","none","none","bomb","none","none","none","none","none","none","treasure"]
    var iconsHard = ["start-button","none","bomb","none","none","three","none","none","none","number","portal","none","none","portal2","none","none","bomb","none","none","none","none","bomb","none","none","none","none","bomb","none","none","none","none","bomb","bomb","treasure"]
    
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
    
    static var reset: [GameItems] {
        var items = [GameItems]()
        switch GameItems.level {
            case .easy:
            icons = ["start-button","none","bomb","none","none","three","none","none","none","number","portal","none","none","portal2","none","none","bomb","none","none","treasure"]
                for index in 0...19 {
                    items.append(GameItems(id: index))
                }
                return items
            case .medium:
                icons = ["start-button","none","bomb","none","none","three","none","none","none","number","portal","none","none","portal2","none","none","bomb","none","none","none","none","bomb","none","none","none","none","bomb","none","none","none","none","none","none","treasure"]
                for index in 0...33 {
                    items.append(GameItems(id: index))
                }
                return items
            case .hard:
                icons = ["start-button","none","bomb","none","none","three","none","none","none","number","portal","none","none","portal2","none","none","bomb","none","none","none","none","bomb","none","none","none","none","bomb","none","none","none","none","bomb","bomb","treasure"]
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
