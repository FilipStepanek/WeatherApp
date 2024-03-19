//
//  AppText.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 15.02.2024.
//

import SwiftUI

struct ContentModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.contentInfo)
            .foregroundColor(.contentRegular)
    }
}

struct ContentSmallInfoModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.contentInfoSmall)
            .foregroundColor(.contentRegular)
    }
}

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.leading)
            .font(.headLineOne)
            .foregroundColor(.mainText)
    }
}

struct ContentMediumModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.contentMedium)
            .foregroundColor(.mainText)
    }
}

struct ContentMediumModifierEnable: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.buttons)
            .foregroundColor(.enableLocationButtonText)
    }
}

struct TemperatureModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.temperatureInformation)
            .foregroundColor(.mainText)
    }
}

struct ContentSmallModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.contentInfoSmall)
            .foregroundColor(.mainText)
    }
}

struct HeadlineThreeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.mediumTitleWatch)
            .foregroundColor(.mainText)
    }
}

struct MediumModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.mediumTitle)
            .foregroundColor(.contentRegular)
    }
}

