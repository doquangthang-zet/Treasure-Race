//
//  MenuView.swift
//  Treasure Race
//
//  Created by Thang Do Quang on 25/08/2023.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack{
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("Color-orange"), Color("Color-red")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                // MARK: - LOGO HEADER
                LogoView(logoFileName: "logo2")
                Spacer()
            }
        }//zstack
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
