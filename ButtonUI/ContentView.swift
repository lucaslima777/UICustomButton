//
//  ContentView.swift
//  ButtonUI
//
//  Created by Lucas Lima Noronha on 26/05/20.
//  Copyright © 2020 Lucas Lima Noronha. All rights reserved.
//

import SwiftUI

extension Color {
    static let white = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    
    static let blueStart = Color(red: 156 / 255, green: 236 / 255, blue: 251 / 255)
    static let blueCenter = Color(red: 101 / 255, green: 199 / 255, blue: 247 / 255)
    static let blueEnd = Color(red: 0 / 255, green: 82 / 255, blue: 212 / 255)
    
    static let blueLight = Color(red: 0 / 255, green: 4 / 255, blue: 40 / 255)
    static let bluekDark = Color(red: 0 / 255, green: 78 / 255, blue: 146 / 255)
    
    static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
    static let lightEnd = Color(red: 30 / 255, green: 80 / 255, blue: 120 / 255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct SimpleButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                Group {
                    if configuration.isPressed {
                        Circle()
                            .fill(Color.white)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(Circle().fill(LinearGradient(Color.blue, Color.clear)))
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask(Circle().fill(LinearGradient(Color.clear, Color.blue)))
                            )
                    } else {
                        Circle()
                            .fill(Color.white)
                            .shadow(color: Color.white.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
                }
            )
    }
}

private struct ColorButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                ColorStyleBackground(isHighlighted: configuration.isPressed, shape: Circle())
            )
            .animation(nil)
    }
}

struct ColorStyleBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S

    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.lightEnd, Color.lightStart))
                    .overlay(shape.stroke(LinearGradient(Color.white, Color.white), lineWidth: 4))
                    .shadow(color: Color.blueStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.blueStart, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color.blueLight, Color.bluekDark))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4))
                    .shadow(color: Color.bluekDark, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.blueLight, radius: 10, x: 10, y: 10)
            }
        }
    }
}

struct ContentView: View {
    
    @State private var iconToggle = false

    var body: some View {
        ZStack {
            LinearGradient(Color.blueStart, Color.blueCenter, Color.blueEnd)
            
            VStack(spacing: 0) {
                Button(action: {
                    self.iconToggle.toggle()
                }) {
                    
                    if iconToggle {
                        Image(systemName: "pause.fill")
                        .foregroundColor(.white)
                    } else {
                        Image(systemName: "play.fill")
                        .foregroundColor(.white)
                    }
                }
                .buttonStyle(ColorButtonStyle())
            }
        } .edgesIgnoringSafeArea(.all)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
