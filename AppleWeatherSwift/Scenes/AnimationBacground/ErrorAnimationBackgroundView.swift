//
//  ErrorAnimationBackgroundView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 05.02.2024.
//

import SwiftUI

import SwiftUI
import Foundation

struct ErrorAnimationBackgroundView: View {
    let endRadiusSize = 450
    
    let color1 = Color.error1
    let color2 = Color.error2
    
    @State var xpos: CGFloat
    @State var ypos: CGFloat = 0
    @State private var scale: CGFloat = 1.0
    @State private var pulsate: Bool = false
    
    init() {
        self.xpos = -UIScreen.main.bounds.width + CGFloat(endRadiusSize)
        self.ypos = 0
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [color1, color2, .mainBackground]),
                        center: .center, startRadius: 0, endRadius: 400)
                )
                .frame(width: 400, height: 400)
                .blur(radius: 90)
                .scaleEffect(pulsate ? 1.6 : 1.2)
                .position(x: xpos, y: ypos)
                .animation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true), value: xpos)
                .onAppear() {
                    self.pulsate.toggle()
                }
        }
        .onAppear {
            xpos = UIScreen.main.bounds.width - 0
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mainBackground)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    ErrorAnimationBackgroundView()
}
