//
//  Font+App.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 15.02.2024.
//

import SwiftUI

extension Font {
    private static let interBold = "Inter-Bold"
    private static let interMedium = "Inter-Medium"
    private static let interRegular = "Inter-Regular"
    private static let interSemibold = "Inter-SemiBold"
    
    enum FontSize: CGFloat {
        case medium = 10
        case headLine1 = 30
        case headLine3 = 32
        case contentRegular = 16
        case contentSmall = 14
        case mediumTitle = 18
    }
    
    // TodayView, ForecastView - temperature
    static let temperatureInformation = (custom(Self.interSemibold, size: Self.FontSize.headLine3.rawValue))
    
    // ErrorInternetConnection, ErrorFetchingData, EnableLocation
    static let headLineOne = (custom(Self.interBold, size: Self.FontSize.headLine1.rawValue))
    
    // Buttons
    static let buttons = (custom(Self.interSemibold, size: Self.FontSize.contentRegular.rawValue))
    
    // Content Info
    static let contentInfo = (custom(Self.interRegular, size: Self.FontSize.contentRegular.rawValue))
    
    // Content Info Small
    static let contentInfoSmall = (custom(Self.interMedium, size: Self.FontSize.contentSmall.rawValue))
    
    // Content Medium
    static let contentMedium = (custom(Self.interMedium, size: Self.FontSize.contentRegular.rawValue))
    
    // Medium Title Temperature Apple Watch - Forecast
    static let mediumTitleWatch = (custom(Self.interBold, size: Self.FontSize.mediumTitle.rawValue))
    
    // Medium Title Temperature - Forecast
    static let mediumTitle = (custom(Self.interMedium, size: Self.FontSize.medium.rawValue))
    
    // Medium Title Temperature Apple Watch - Forecast
    static let contentSmall = (custom(Self.interMedium, size: Self.FontSize.contentSmall.rawValue))
}
