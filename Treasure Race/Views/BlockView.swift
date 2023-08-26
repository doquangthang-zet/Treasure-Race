//
//  BlockView.swift
//  Treasure Race
//
//  Created by Thang Do Quang on 25/08/2023.
//

import SwiftUI

struct BlockView: View {
    var itemName: String
    
    var body: some View {
        ZStack{
            Image("frame_black")
                .resizable()
                .modifier(BlockModifier())
            Image(itemName)
                .resizable()
                .frame(width: 20, height: 20)
                .modifier(ShadowModifier())
        }
    }
}

struct BlockView_Previews: PreviewProvider {
    static var previews: some View {
        BlockView(itemName: "treasure")
    }
}
