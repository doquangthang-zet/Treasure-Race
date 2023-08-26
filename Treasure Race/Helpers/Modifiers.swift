//
//  Modifiers.swift
//  Treasure Race
//
//  Created by Thang Do Quang on 25/08/2023.
//

import SwiftUI

struct ShadowModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .shadow(color:Color("Color-black-transparent"), radius: 7)
    }
}

struct AvatarImageModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 30, idealWidth: 60, maxWidth: 80, alignment: .center)
            .padding()
            .modifier(ShadowModifier())
    }
}

struct BlockModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(width: 40, height: 40)
            .modifier(ShadowModifier())
    }
}
    
