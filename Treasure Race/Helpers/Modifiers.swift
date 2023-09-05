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
            .frame(minWidth: 30, idealWidth: 60, maxWidth: 100, alignment: .center)
            .padding()
            .modifier(ShadowModifier())
    }
}

struct BlockModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 40,idealWidth: 40, maxWidth: 40, minHeight: 40,idealHeight: 40,maxHeight: 40)
            .modifier(ShadowModifier())
    }
}

struct IconsModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 30, idealWidth: 30,maxWidth: 30, minHeight: 30,idealHeight: 30, maxHeight: 30)
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
                    .frame(minWidth: 250, maxWidth: 400, minHeight: 60, maxHeight: 100, alignment: .center)
                
                    
            )
            .overlay(
                Capsule()
                    .stroke(Color("Color-border"), lineWidth: 4)
                    .frame(minWidth: 250, maxWidth: 400, minHeight: 60, maxHeight: 100, alignment: .center)
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
