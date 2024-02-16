//
//  ButtonStyle.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 15.02.2024.
//

import SwiftUI

struct ReloadButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 40, height: 40)
            .background(.reloadBackground)
            .contentShape(Rectangle())
            .cornerRadius(40)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

struct EnableButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .contentShape(Rectangle())
            .background(.white)
            .cornerRadius(28)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

struct ForecastButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 35, height: 35)
            .background(.forecastButtonBackground)
            .contentShape(Rectangle())
            .cornerRadius(40)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
