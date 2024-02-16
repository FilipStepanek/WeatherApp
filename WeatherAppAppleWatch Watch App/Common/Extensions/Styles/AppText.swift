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
            .foregroundColor(.mainTextWatch)
    }
}

struct ContentMediumModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.contentMedium)
            .foregroundColor(.mainTextWatch)
    }
}

struct ContentMediumModifierEnable: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.buttons)
            .foregroundColor(.enableLocationButtonTextWatch)
    }
}

struct TemperatureModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.temperatureInformation)
            .foregroundColor(.mainTextWatch)
    }
}

struct ContentSmallModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.contentInfoSmall)
            .foregroundColor(.mainTextWatch)
    }
}

struct HeadlineThreeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.mediumTitleWatch)
            .foregroundColor(.mainTextWatch)
    }
}

struct MediumModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.mediumTitle)
            .foregroundColor(.contentRegular)
    }
}

