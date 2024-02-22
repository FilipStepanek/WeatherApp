//
//  Font+App.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 15.11.2023.
//

import SwiftUI

extension Font {
    private static let interBold = "Inter-Bold"
    private static let interMedium = "Inter-Medium"
    private static let interRegular = "Inter-Regular"
    private static let interSemibold = "Inter-SemiBold"
    
    enum FontSize: CGFloat {
        case tabBar = 10
        case headLine1 = 64
        case headLine2 = 40
        case headLine3 = 32
        case contentRegular = 16
        case contentSmall = 14
        case mediumTitle = 18
        case largeTitle = 30
        case extraLargeTitle = 70
        case dayInfoFont = 20
    }
    
    // Current Lotaion Data - Font
    static let myLocationTitle = (custom(Self.interBold, size: Self.FontSize.largeTitle.rawValue))
    static let myLocationText = (custom(Self.interBold, size: Self.FontSize.largeTitle.rawValue))
    static let myLocationTemperature = (custom(Self.interBold, size: Self.FontSize.extraLargeTitle.rawValue))
    static let myLocationWeather = (custom(Self.interBold, size: Self.FontSize.mediumTitle.rawValue))
    
    // Tab Bar
    static let tabBarFont = (custom(Self.interBold, size: Self.FontSize.tabBar.rawValue))
    
    // Head Line 1
    static let headLineOne = (custom(Self.interBold, size: Self.FontSize.headLine1.rawValue))
    
    // Error detail information
    static let errorDetailInfo = (custom(Self.interMedium, size: Self.FontSize.contentRegular.rawValue))
    
    // Buttons
    static let buttons = (custom(Self.interSemibold, size: Self.FontSize.contentRegular.rawValue))
    
    // Temperature
    static let temperatureInformation = (custom(Self.interSemibold, size: Self.FontSize.headLine3.rawValue))
    
    // Content Info
    static let contentInfo = (custom(Self.interRegular, size: Self.FontSize.contentRegular.rawValue))
    
    // Content Info Small
    static let contentInfoSmall = (custom(Self.interMedium, size: Self.FontSize.contentSmall.rawValue))
    
    // Content Medium
    static let contentMedium = (custom(Self.interMedium, size: Self.FontSize.contentRegular.rawValue))
    
    // Headline 3
    static let headlineThree = (custom(Self.interSemibold, size: Self.FontSize.headLine3.rawValue))
    
    // Day Info Font
    static let dayInfo = (custom(Self.interSemibold, size: Self.FontSize.dayInfoFont.rawValue))
    
    // Headline 2
    static let headlineTwo = (custom(Self.interBold, size: Self.FontSize.headLine2.rawValue))
    
    // Medium Title Temperature Apple Watch - Forecast
    static let mediumTitleWatch = (custom(Self.interBold, size: Self.FontSize.mediumTitle.rawValue))
    
    // Medium Title Temperature Apple Watch - Forecast
    static let mediumWatch = (custom(Self.interMedium, size: Self.FontSize.tabBar.rawValue))
    
    // Medium Title Temperature Apple Watch - Forecast
    static let contentSmallWatch = (custom(Self.interMedium, size: Self.FontSize.contentSmall.rawValue))
}
