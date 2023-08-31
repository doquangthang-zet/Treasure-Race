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

struct LightShadowModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .shadow(color:Color("Color-purple"), radius: 7)
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

struct IconsModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(width: 30, height: 30)
            .modifier(ShadowModifier())
    }
}
 
struct ButtonMenuModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.custom("LilitaOne", size: 30))
            .foregroundColor(Color("Color-purple"))
            .background(
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("Color-red"), Color("Color-orange-light")]), startPoint: .bottom, endPoint: .top))
                    .frame(width: 250, height: 60, alignment: .center)
                
                    
            )
            .overlay(
                Capsule()
                    .stroke(Color("Color-border"), lineWidth: 4)
                    .frame(width: 250, height: 60, alignment: .center)
            )
            .padding(30)
    }
}

struct ScoreModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.custom("LilitaOne", size: 20))
            .foregroundColor(Color("Color-purple"))
            .background(
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("Color-red"), Color("Color-orange-light")]), startPoint: .bottom, endPoint: .top))
                    .frame(width: 150, height: 35, alignment: .center)
            )
            .overlay(
                Capsule()
                    .stroke(Color("Color-border"), lineWidth: 4)
                    .frame(width: 150, height: 35, alignment: .center)
            )
    }
}

struct LevelButtonModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.custom("LilitaOne", size: 20))
            .foregroundColor(Color("Color-purple"))
            .background(
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("Color-red"), Color("Color-orange-light")]), startPoint: .bottom, endPoint: .top))
                    .frame(width: 120, height: 35, alignment: .center)
            )
            .overlay(
                Capsule()
                    .stroke(Color("Color-border"), lineWidth: 4)
                    .frame(width: 130, height: 35, alignment: .center)
            )
    }
}
