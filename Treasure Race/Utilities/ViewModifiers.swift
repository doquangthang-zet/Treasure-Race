//
//  ViewModifiers.swift
//  tiktactoe
//
//  Created by Thang Do Quang on 26/08/2023.
//
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

struct NavStackContainer: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16, *) {
            NavigationStack{
                content
            }
        } else {
            NavigationView {
                content
            }
            .navigationViewStyle(.stack)
        }
    }
}

extension View {
    public func inNavigationStack() -> some View {
        return self.modifier(NavStackContainer())
    }
}
