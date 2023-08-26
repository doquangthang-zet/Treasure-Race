//
//  GameService.swift
//  tiktactoe
//
//  Created by Thang Do Quang on 26/08/2023.
//

import SwiftUI

@MainActor
class GameService: ObservableObject {
    @Published var player1 = Player(gamePiece: .pirate, name: "Player 1")
    @Published var player2 = Player(gamePiece: .knight, name: "Player 2")
    @Published var possibleMoves = Move.all
    @Published var gameOver = false
    @Published var gameBoard = GameSquare.reset
    
    var gameType = GameType.single
    
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
    
    func setupGame(gameType: GameType, player1Name: String, player2Name: String) {
        switch gameType {
        case .single:
            self.gameType = .single
            player2.name = player2Name
        case .bot:
            self.gameType = .bot
        case .undetermined:
            break
        }
        player1.name = player1Name
    }
    
    func reset() {
        player1.isCurrent = false
        player2.isCurrent = false
        player1.position = 0
        player2.position = 0
        gameOver = false
        possibleMoves = Move.all
        gameBoard = GameSquare.reset
    }
    
    func updateMoves(index: Int) {
        if player1.isCurrent {
            player1.position = index
            gameBoard[index].player = player1
        } else {
            player2.position = index
            gameBoard[index].player = player2
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
    
    func makeMove(at index: Int) {
        if gameBoard[index].player == nil {
            withAnimation {
                updateMoves(index: index)
            }
            checkIfWinner()
        }
        if !gameOver {
            toggleCurrent()
        }
    }
}
