//
//  test.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 27.11.2023.
//

import SwiftUI

struct TodayAnimationBackgroundView: View {
    let endRadiusSize = 450
    var weather: CurrentResponse
    
    @State var xpos: CGFloat
    @State var ypos: CGFloat = 0
    @State private var scale: CGFloat = 1.0
    @State private var pulsate: Bool = false
    
    init(weather: CurrentResponse) {
        self.weather = weather
        self.xpos = -UIScreen.main.bounds.width + CGFloat(endRadiusSize)
    }
    
    var body: some View {
        ZStack {
            Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [WeatherManagerExtension().getColor1(icon: weather.weather.first?.icon ?? ""), WeatherManagerExtension().getColor2(icon: weather.weather.first?.icon ?? ""), .mainBackground]),
                                center: .center, startRadius: 0, endRadius: 400)
                            )
                        .frame(width: 400, height: 400)
                .blur(radius: 90)
                .scaleEffect(pulsate ? 1.6 : 1.2)
                .position(x: xpos, y: ypos)
                .animation(.easeInOut(duration: 7.0).repeatForever(autoreverses: true), value: xpos)
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
    TodayAnimationBackgroundView(weather: previewWeather)
}
