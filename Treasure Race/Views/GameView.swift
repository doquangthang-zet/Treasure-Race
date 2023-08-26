//
//  GameView.swift
//  Treasure Race
//
//  Created by Thang Do Quang on 25/08/2023.
//

import SwiftUI

// MARK: - GAME UI View
struct GameView: View {
    // MARK: - PROPERTIES
    @State private var icons = ["start-button","none","bomb","none","heart","none","none","none","none","none","portal","none","none","portal","none","none","shield","none","none","treasure"]
    
    @State private var blocks = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
    
    @State private var player1Avatar = "pirate"
    @State private var player2Avatar = "knight"
    
    @State private var diceResult1 = 1
    @State private var diceResult2 = 1
    
    @State private var player1Position = 0
    @State private var player2Position = 0
    
    @State private var player1Turn = false
    @State private var player2Turn = true
    
    // MARK: - FUNCTIONS (GAME LOGICS)
    //MARK: - ROLL DICE LOGIC
    func rollDice1() {
        diceResult1 = Int.random(in: 1...6)
    }
    func rollDice2() {
        diceResult2 = Int.random(in: 1...6)
    }
    
    //MARK: - CHECK POSITIONS
    
    
    //MARK: - PLAYER MOVING
    func move(position: Int, steps: Int) {
        player2Position += steps
        icons[player2Position] = player2Avatar
        
    }
    
    var body: some View {
        //MARK: BODY
        ZStack{
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("Color-blue"), Color("Color-purple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            //MARK: - VSTACK
            VStack{
                //MARK: - PLAYER 1 BOX
                HStack{
                    Button {
                        rollDice1()
                    } label: {
                        Image("dice\(diceResult1)")
                            .resizable()
                            .modifier(AvatarImageModifier())
                            .offset(x: player1Turn ? 0 : 20)
                            .opacity(player1Turn ? 1 : 0 )
                            .animation(.default, value: player1Turn)

                    }
                    Spacer()
                    Text("Player 1")
//                        .font(.custom("LilitaOne-Regular", size: 20))
                        .fontWeight(.heavy)
                    Image(player1Avatar)
                        .resizable()
                        .modifier(AvatarImageModifier())
                }
                Spacer()
                
                //MARK: - GAME MAP
                VStack{
                    HStack{
                        VStack{
                            Image(player1Avatar)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .modifier(ShadowModifier())
                            Image(player2Avatar)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .modifier(ShadowModifier())
                        }
                        
                        BlockView(itemName: icons[0])
                        BlockView(itemName: icons[1])
                        BlockView(itemName: icons[2])
                        BlockView(itemName: icons[3])
                        BlockView(itemName: icons[4])
                        BlockView(itemName: icons[5])
                    }
                    HStack{
                        Spacer()
                        BlockView(itemName: icons[6])
                            .padding(.trailing)
                            .padding(.trailing)
                    }
                    HStack{
                        BlockView(itemName: icons[12])
                        BlockView(itemName: icons[11])
                        BlockView(itemName: icons[10])
                        BlockView(itemName: icons[9])
                        BlockView(itemName: icons[8])
                        BlockView(itemName: icons[7])
                    }
                    HStack{
                        BlockView(itemName: icons[13])
                            .padding(.leading)
                            .padding(.leading)
                        Spacer()
                    }
                    HStack{
                        BlockView(itemName: icons[14])
                        BlockView(itemName: icons[15])
                        BlockView(itemName: icons[16])
                        BlockView(itemName: icons[17])
                        BlockView(itemName: icons[18])
                        BlockView(itemName: icons[19])
                    }
                }
                Spacer()
                
                //MARK: - PLAYER 2 BOX
                HStack{
                    Image(player2Avatar)
                        .resizable()
                        .modifier(AvatarImageModifier())
                    Text("Player 2")
//                        .font(.custom("LilitaOne-Regular", size: 20))
                        .fontWeight(.heavy)
                    Spacer()
                    Button {
                        rollDice2()
                        move(position: player2Position, steps: 1)
                    } label: {
                        Image("dice\(diceResult2)")
                            .resizable()
                            .modifier(AvatarImageModifier())
                            .offset(x: player2Turn ? 0 : 20)
                            .opacity(player2Turn ? 1 : 0 )
                            .animation(.default, value: player2Turn)
                    }
                }
            }//Close vstack
        }//Close zstack
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
