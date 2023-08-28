//
//  GameService.swift
//  tiktactoe
//
//  Created by Thang Do Quang on 26/08/2023.
//

import SwiftUI

@MainActor
class GameService: ObservableObject {
    @Published var player1 = Player(avatar: "pirate", name: "Player 1")
    @Published var player2 = Player(avatar: "knight", name: "Player 2")
    @Published var possibleMoves = true
    @Published var gameOver = false
    @Published var gameBoard = GameSquare.reset
    @Published var gameItems = GameItems.reset
    @Published var isThinking = false
    @Published var winPosition = 19
    
    var gameType = GameType.single
    var gameLevel = GameLevel.easy
    
    var currentPlayer: Player {
        if player1.isCurrent {
            return player1
        } else {
            return player2
        }
    }
    
    var gameStart: Bool {
        player1.isCurrent || player2.isCurrent
    }
    
    var boardDisabled: Bool {
        gameOver || !gameStart
    }
    
    func setupLevel(gameLevel: GameLevel) {
        GameItems.level = gameLevel
        switch gameLevel {
        case .easy:
            self.gameLevel = .easy
            gameBoard = GameSquare.reset
            gameItems = GameItems.reset
            winPosition = 19
        case .medium:
            self.gameLevel = .medium
            gameBoard = GameSquare.resetMedium
            gameItems = GameItems.resetMedium
            winPosition = 33
        case .hard:
            self.gameLevel = .hard
            gameBoard = GameSquare.resetMedium
            gameItems = GameItems.resetHard
            winPosition = 33
        }
    }
    
    func setupGame(gameType: GameType, player1Name: String, player2Name: String, player1Avatar: String, player2Avatar: String) {
        switch gameType {
        case .single:
            self.gameType = .single
            player2.name = player2Name
            player2.avatar = player2Avatar
        case .bot:
            self.gameType = .bot
            player2.name = UIDevice.current.name
            player2.avatar = "phone2"
        case .undetermined:
            break
        }
        switch gameLevel {
        case .easy:
            winPosition = 19
        case .medium:
            winPosition = 33
        case .hard:
            winPosition = 33
        }
        player1.name = player1Name
        player1.avatar = player1Avatar
    }
    
    func reset() {
        player1.isCurrent = false
        player2.isCurrent = false
        player1.position = -1
        player2.position = -1
        player1.score = 0
        player2.score = 0
        player1.onRoad = false
        player2.onRoad = false
        player1.isWinner = false
        player2.isWinner = false
        gameOver = false
        
        isThinking = false
        switch gameLevel {
        case .easy:
            gameBoard = GameSquare.reset
            gameItems = GameItems.reset
            winPosition = 19
        case .medium:
            gameBoard = GameSquare.resetMedium
            gameItems = GameItems.resetMedium
            winPosition = 33
        case .hard:
            gameBoard = GameSquare.resetMedium
            gameItems = GameItems.resetHard
            winPosition = 33
        }
    }
    
    func updateMoves(index: Int) {
        switch gameLevel {
        case .easy:
            gameItems = GameItems.reset
        case .medium:
            gameItems = GameItems.resetMedium
        case .hard:
            gameItems = GameItems.resetHard
        }
        var newIndex = index
        
        if player1.isCurrent {
            if checkMove(index: index) == "bomb" {
                player1.position = -1
                player1.onRoad = false
            } else if checkMove(index: index) == "three" {
                newIndex += 3
                player1.position += 3
                gameItems[newIndex].player = player1
            } else if checkMove(index: index) == "number" {
                newIndex -= 2
                player1.position -= 2
                gameItems[newIndex].player = player1
            } else if checkMove(index: index) == "portal" {
                newIndex += 3
                player1.position += 3
                gameItems[newIndex].player = player1
            } else if index == player2.position {
                player2.position = -1
                player2.onRoad = false
                player1.score += 100
                gameItems[index].player = player1
            } else {
                gameItems[index].player = player1
            }

            if player2.position >= 0 {
                gameItems[player2.position].player = player2
            }
        } else {
            if checkMove(index: index) == "bomb" {
                player2.position = -1
                player2.onRoad = false
            } else if checkMove(index: index) == "three" {
                newIndex += 3
                player2.position += 3
                gameItems[newIndex].player = player2
            } else if checkMove(index: index) == "number" {
                newIndex -= 2
                player2.position -= 2
                gameItems[newIndex].player = player2
            } else if checkMove(index: index) == "portal" {
                newIndex += 3
                player2.position += 3
                gameItems[newIndex].player = player2
            } else if index == player1.position {
                player1.position = -1
                player1.onRoad = false
                gameItems[index].player = player2
            } else {
                gameItems[index].player = player2
            }

            if player1.position >= 0 {
                gameItems[player1.position].player = player1
            }
        }
    }
    
    func checkIfWinner() {
        if player1.isWinner || player2.isWinner {
            gameOver = true
        }
    }
    
    func toggleCurrent (){
        player1.isCurrent.toggle()
        player2.isCurrent.toggle()
    }
    
    func checkMove(index: Int) -> String {
        if gameItems[index].icons[index] == "bomb" {
            return "bomb"
        } else if gameItems[index].icons[index] == "three"{
            return "three"
        } else if gameItems[index].icons[index] == "number"{
            return "number"
        } else if gameItems[index].icons[index] == "portal"{
            return "portal"
        } else {
            return "none"
        }
    }
    
    func makeMove() {
        if player1.isCurrent {
            player1.rollDice()
            player1.diceValue = Dice.current
            if player1.onRoad == false {
                if Dice.current == 1 || Dice.current == 6 {
                    player1.onRoad = true
                    player1.position = 0
                    player1.score += 100
                    possibleMoves = true
                    withAnimation {
                        updateMoves(index: 0)
                    }
                    toggleCurrent()
                } else {
                    possibleMoves = false
                }
            } else {
                if player1.position + Dice.current > winPosition {
                    possibleMoves = false
                } else {
                    player1.position += Dice.current
                    possibleMoves = true
                    withAnimation {
                        updateMoves(index: player1.position)
                    }
                }
            }
        } else {
            player2.rollDice()
            player2.diceValue = Dice.current
            if player2.onRoad == false {
                if Dice.current == 1 || Dice.current == 6 {
                    player2.onRoad = true
                    player2.position = 0
                    possibleMoves = true
                    withAnimation {
                        updateMoves(index: 0)
                    }
                    toggleCurrent()
                } else {
                    possibleMoves = false
                }
            } else {
                if player2.position + Dice.current > winPosition {
                    possibleMoves = false
                } else {
                    player2.position += Dice.current
                    possibleMoves = true
                    withAnimation {
                        updateMoves(index: player2.position)
                    }
                }
            }
        }
        checkIfWinner()
        if !gameOver {
            toggleCurrent()
            if gameType == .bot && currentPlayer.name == player2.name {
                Task{
                    await iphoneMove()
                }
            }
        }
        if player1.position == winPosition {
            gameOver = true
            player1.isWinner = true
            player1.score += 100
        }
        if player2.position == winPosition {
            gameOver = true
            player2.isWinner = true
            player2.score += 100
        }
    }
    
    func iphoneMove() async {
        isThinking.toggle()
        try? await Task.sleep(nanoseconds: 1000_000_000)
        makeMove()
        isThinking.toggle()
    }
}
