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

@MainActor
class GameService: ObservableObject {
    //MARK: GAME VARIABLES
    @Published var player1 = Player(avatar: "pirate", name: "Player 1")
    @Published var player2 = Player(avatar: "knight", name: "Player 2")
    @Published var player1Exist = false
    @Published var player2Exist = false
    @Published var possibleMoves = true
    @Published var getBomb = false
    @Published var gameOver = false
    @Published var getPortal = false
    @Published var isKicked = false
    @Published var gameBoard = GameSquare.reset
    @Published var gameItems = GameItems.reset
    @Published var isThinking = false
    @Published var winPosition = 19
    @Published var showBadge = false
    
    @Published var users:[Player] = [] {
        didSet{
            savePlayerStatus()
        }
    }
    let userKey: String = "users_list"
    
    //MARK: GAME RESTORED VARIABLES
    @AppStorage("gameLevel") var gameLevelStored: GameLevel = .easy
    @AppStorage("gameType") var gameTypeStored: GameType = .undetermined
    @AppStorage("player1Name") var player1NameStored = "Player1"
    @AppStorage("player2Name") var player2NameStored = "Player2"
    @AppStorage("player1Avatar") var player1AvatarStored = "Player1"
    @AppStorage("player2Avatar") var player2AvatarStored = "Player2"
    @AppStorage("player1Current") var player1CurrentStored = false
    @AppStorage("player2Current") var player2CurrentStored = false
    @AppStorage("player1Pos") var player1PosStored = -1
    @AppStorage("player2Pos") var player2PosStored = -1
    @AppStorage("player1Score") var player1ScoreStored = 0
    @AppStorage("player2Score") var player2ScoreStored = 0
    @AppStorage("player1On") var player1Onroad = false
    @AppStorage("player2On") var player2Onroad = false
    @AppStorage("player1win") var player1win = false
    @AppStorage("player2win") var player2win = false
    @AppStorage("gameover") var gameoverStored = false
    
    
    @AppStorage("isDarkMode") var isDark = false
    @AppStorage("setLanguage") var language = "en"
    @AppStorage("setProgress") var progress = false
    
    var gameType = GameType.single
    var gameLevel = GameLevel.easy
    
    //MARK: - CHECK CURRENT PLAYER
    var currentPlayer: Player {
        if player1.isCurrent {
            return player1
        } else {
            return player2
        }
    }
    
    //MARK: - CHECK GAME START STATUS
    var gameStart: Bool {
        player1.isCurrent || player2.isCurrent
    }
    
    //MARK: - CHECK CURRENT PLAYER
//    var boardDisabled: Bool {
//        gameOver || !gameStart
//    }
    
    //MARK: - FUNCTION TO SETUP LEVEL FOR NEW GAME
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
    
    //MARK: - FUNCTION TO SETUP NEW GAME
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
        reset()
    }
    
    //MARK: - FUNCTION TO RESET GAME
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
    
    //MARK: - FUNCTION TO UPDATE PLAYER MOVE
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
        
        //MARK: - CHECK PLAYER 1 MOVE
        if player1.isCurrent {
            if checkMove(index: index) == "bomb" {
                getBomb = true
                getPortal = false
                isKicked = false
                player1.position = -1
                player1.onRoad = false
            } else if checkMove(index: index) == "three" {
                getBomb = false
                getPortal = true
                isKicked = false
                newIndex += 3
                player1.position += 3
                gameItems[newIndex].player = player1
            } else if checkMove(index: index) == "number" {
                getBomb = false
                getPortal = true
                isKicked = false
                newIndex -= 2
                player1.position -= 2
                gameItems[newIndex].player = player1
            } else if checkMove(index: index) == "portal" {
                getBomb = false
                getPortal = true
                isKicked = false
                newIndex += 3
                player1.position += 3
                gameItems[newIndex].player = player1
            } else if index == player2.position {
                getBomb = false
                getPortal = false
                isKicked = true
                player2.position = -1
                player2.onRoad = false
                player1.score += 100
                if !player1.getBadge2 {
                    player1.getBadge2 = true
                }
                gameItems[index].player = player1
            } else {
                getBomb = false
                getPortal = false
                isKicked = false
                gameItems[index].player = player1
            }

            if player2.position >= 0 {
                gameItems[player2.position].player = player2
            }
        } else { //MARK: - CHECK PLAYER 2 MOVE
            if checkMove(index: index) == "bomb" {
                getBomb = true
                getPortal = false
                isKicked = false
                player2.position = -1
                player2.onRoad = false
            } else if checkMove(index: index) == "three" {
                getBomb = false
                getPortal = true
                isKicked = false
                newIndex += 3
                player2.position += 3
                gameItems[newIndex].player = player2
            } else if checkMove(index: index) == "number" {
                getBomb = false
                getPortal = true
                isKicked = false
                newIndex -= 2
                player2.position -= 2
                gameItems[newIndex].player = player2
            } else if checkMove(index: index) == "portal" {
                getBomb = false
                getPortal = true
                isKicked = false
                newIndex += 3
                player2.position += 3
                gameItems[newIndex].player = player2
            } else if index == player1.position {
                getBomb = false
                getPortal = false
                isKicked = true
                player1.position = -1
                player1.onRoad = false
                player2.score += 100
                if !player2.getBadge2 {
                    player2.getBadge2 = true
                }
                gameItems[index].player = player2
            } else {
                getBomb = false
                getPortal = false
                isKicked = false
                gameItems[index].player = player2
            }

            if player1.position >= 0 {
                gameItems[player1.position].player = player1
            }
        }
    }
    
    //MARK: - FUNCTION TO CHECK IF A PLAYER IS WINNER
    func checkIfWinner() {
        if player1.isWinner || player2.isWinner {
            gameOver = true
        }
    }
    
    //MARK: - CHANGE CURRENT PLAYER
    func toggleCurrent (){
        player1.isCurrent.toggle()
        player2.isCurrent.toggle()
    }
    
    //MARK: - CHECK OBSTACLES ON MAP
    func checkMove(index: Int) -> String {
        if gameLevel == .easy {
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
        } else if gameLevel == .medium {
            if gameItems[index].iconsMedium[index] == "bomb" {
                return "bomb"
            } else if gameItems[index].iconsMedium[index] == "three"{
                return "three"
            } else if gameItems[index].iconsMedium[index] == "number"{
                return "number"
            } else if gameItems[index].iconsMedium[index] == "portal"{
                return "portal"
            } else {
                return "none"
            }
        } else {
            if gameItems[index].iconsHard[index] == "bomb" {
                return "bomb"
            } else if gameItems[index].iconsHard[index] == "three"{
                return "three"
            } else if gameItems[index].iconsHard[index] == "number"{
                return "number"
            } else if gameItems[index].iconsHard[index] == "portal"{
                return "portal"
            } else {
                return "none"
            }
        }
    }
    
    //MARK: - FUNCTION TO MOVE
    func makeMove() {
        if player1.isCurrent {
            player1.rollDice()
            player1.diceValue = Dice.current
            
            //MARK: - CHECK IF PLAYER 1 IS ON MAP OR NOT
            if player1.onRoad == false {
                if Dice.current == 1 || Dice.current == 6 {
                    player1.onRoad = true
                    player1.position = 0
                    player1.score += 100
                    possibleMoves = true
                    if !player1.getBadge1 {
                        player1.getBadge1 = true
                    }
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
            
            //MARK: - CHECK IF PLAYER 2 IS ON MAP OR NOT
            if player2.onRoad == false {
                if Dice.current == 1 || Dice.current == 6 {
                    player2.onRoad = true
                    player2.position = 0
                    player2.score += 100
                    possibleMoves = true
                    if !player2.getBadge1 {
                        player2.getBadge1 = true
                    }
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
        
        //MARK: - CHECK IF THE GAME NOT OVER CHANGE PLAYER'S TURN
        checkIfWinner()
        if !gameOver {
            toggleCurrent()
            if gameType == .bot && currentPlayer.name == player2.name {
                Task{
                    await iphoneMove()
                }
            }
        }
        
        //MARK: - CHECK IF PLAYER 1 IS WINNER
        if player1.position == winPosition {
            gameOver = true
            player1.isWinner = true
            player1.score += 100
            if !player1.getBadge3 {
                player1.getBadge3 = true
            }
            for u in users {
                if u.name == player1.name {
                    player1Exist = true
                } else if u.name == player2.name {
                    player2Exist = true
                }
            }
            
            switch gameType {
            case .single:
                if player1Exist {
                    updateUser(u: player1)
                } else {
                    addUser(u: player1)
                }
                if player2Exist {
                    updateUser(u: player2)
                } else {
                    addUser(u: player2)
                }
            case .bot:
                if player1Exist {
                    updateUser(u: player1)
                } else {
                    addUser(u: player1)
                }
            case .undetermined:
                break
            }
        }
        
        //MARK: - CHECK IF PLAYER 2 IS WINNER
        if player2.position == winPosition {
            gameOver = true
            player2.isWinner = true
            player2.score += 100
            if !player2.getBadge3 {
                player2.getBadge3 = true
            }
            for u in users {
                if u.name == player1.name {
                    player1Exist = true
                } else if u.name == player2.name {
                    player2Exist = true
                }
            }
            
            switch gameType {
            case .single:
                if player1Exist {
                    updateUser(u: player1)
                } else {
                    addUser(u: player1)
                }
                if player2Exist {
                    updateUser(u: player2)
                } else {
                    addUser(u: player2)
                }
            case .bot:
                if player1Exist {
                    updateUser(u: player1)
                } else {
                    addUser(u: player1)
                }
            case .undetermined:
                break
            }
        }
    }
    
    //MARK: - FUNCTION FOR MACHINE TO MOVE
    func iphoneMove() async {
        isThinking.toggle()
        try? await Task.sleep(nanoseconds: 1000_000_000)
        makeMove()
        isThinking.toggle()
    }
    
    //MARK: - FUNCTION TO GET STORED PLAYER INFORMATION
    func getUsers() {
        guard
            let data = UserDefaults.standard.data(forKey: userKey),
            let savedUser = try? JSONDecoder().decode([Player].self, from: data)
        else { return }
        
        self.users = savedUser
    }
    
    //MARK: - FUNCTION TO ADD PLAYER INFOR TO USERS ARRAY
    func addUser(u: Player) {
        users.append(u)
    }
    
    //MARK: - FUNCTION TO UPDATE PLAYER IF THEIR NAME IS EXIST
    func updateUser(u: Player) {
        if let index = users.firstIndex(where: { $0.name == u.name}) {
            users[index] = u
        }
    }
    
    //MARK: - FUNCTION TO SAVE PLAYER INFOR TO @APPSTORAGE
    func savePlayerStatus() {
        if let encodedData = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encodedData, forKey: userKey)
        }
    }
    
    //MARK: - FUNCTION TO SAVE CURRENT PROGRESS
    func saveProgress() {
        progress = true
        gameLevelStored = gameLevel
        gameTypeStored = gameType
        player1NameStored = player1.name
        player2NameStored = player2.name
        player1AvatarStored = player1.avatar
        player2AvatarStored = player2.avatar
        player1CurrentStored = player1.isCurrent
        player2CurrentStored = player2.isCurrent
        player1PosStored = player1.position
        player2PosStored = player2.position
        player1ScoreStored = player1.score
        player2ScoreStored = player2.score
        player1Onroad = player1.onRoad
        player2Onroad = player2.onRoad
        player1win = player1.isWinner
        player2win = player2.isWinner
        gameoverStored = gameOver
    }
    
    //MARK: - FUNCTION TO RESTORE GAME PROGRESS
    func restore() {
        setupGame(gameType: gameTypeStored, player1Name: player1NameStored, player2Name: player2NameStored, player1Avatar: player1AvatarStored, player2Avatar: player2AvatarStored)
        setupLevel(gameLevel: gameLevelStored)
        
        player1.isCurrent = player1CurrentStored
        player2.isCurrent = player2CurrentStored
        player1.position = player1PosStored
        player2.position = player2PosStored
        player1.score = player1ScoreStored
        player2.score = player2ScoreStored
        player1.onRoad = player1Onroad
        player2.onRoad = player2Onroad
        player1.isWinner = player1win
        player2.isWinner = player2win
        gameOver = gameoverStored
    }
}
